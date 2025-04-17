# Creating a Homebrew Formula

This guide provides step-by-step instructions for creating a Homebrew formula and adding it to this tap repository.

## What is a Homebrew Formula?

A Homebrew formula is a Ruby script that defines how to install a piece of software using the Homebrew package manager. Formulas contain metadata about the software and instructions for downloading, building, and installing it.

## Step-by-Step Guide

### Step 1: Set Up Your Development Environment

1. Ensure you have Homebrew installed:

   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. Clone this tap repository:

   ```bash
   git clone https://github.com/yourusername/homebrew-tap.git
   cd homebrew-tap
   ```

3. Create a Formula directory if it doesn't exist:

   ```bash
   mkdir -p Formula
   ```

### Step 2: Create Your Formula File

1. Create a new Ruby file in the Formula directory. The filename should be the name of your software in lowercase:

   ```bash
   touch Formula/your_software.rb
   ```

2. The class name inside the file should be the CamelCase version of the filename:

   ```ruby
   class YourSoftware < Formula
     # Formula contents go here
   end
   ```

### Step 3: Define Your Formula

Here's a basic template for a formula:

```ruby
class YourSoftware < Formula
  desc "Brief description of your software"
  homepage "https://your-software-website.com"
  url "https://github.com/username/project/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "checksum_of_your_tarball"
  license "MIT" # or appropriate license

  # Dependencies
  depends_on "cmake" => :build # Example build dependency
  depends_on "openssl" # Example runtime dependency

  def install
    # Installation instructions
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"

    # If your software doesn't have a build system, you can use:
    # bin.install "executable_name"
    # lib.install "library_file.so"
    # include.install "header_file.h"
  end

  test do
    # Test to verify installation was successful
    system "#{bin}/your_software", "--version"
  end
end
```

### Step 4: Generate SHA-256 Checksum

1. Download the source tarball:

   ```bash
   curl -OL https://github.com/username/project/archive/refs/tags/v1.0.0.tar.gz
   ```

2. Generate the SHA-256 checksum:

   ```bash
   shasum -a 256 v1.0.0.tar.gz
   ```

3. Copy the generated checksum into your formula.

### Step 5: Customize Installation Instructions

Modify the `install` method based on how your software needs to be built:

#### For CMake projects

```ruby
def install
  system "cmake", "-S", ".", "-B", "build", *std_cmake_args
  system "cmake", "--build", "build"
  system "cmake", "--install", "build"
end
```

#### For Go projects

```ruby
def install
  system "go", "build", *std_go_args(ldflags: "-s -w")
end
```

#### For pre-compiled binaries

```ruby
def install
  bin.install "executable_name"
  # For multiple binaries:
  # bin.install Dir["bin/*"]
end
```

### Step 6: Add a Test

The `test` block should contain a simple test to verify the installation:

```ruby
test do
  assert_match "version 1.0.0", shell_output("#{bin}/your_software --version")
end
```

### Step 7: Test Your Formula Locally

1. Install from your local formula:

   ```bash
   brew install --build-from-source ./Formula/your_software.rb
   ```

2. If there are issues, you can debug with:

   ```bash
   brew install --debug --verbose ./Formula/your_software.rb
   ```

3. Test the installation:

   ```bash
   brew test ./Formula/your_software.rb
   ```

4. Audit your formula for potential issues:

   ```bash
   brew audit --strict --online ./Formula/your_software.rb
   ```

### Step 8: Commit and Push Your Formula

1. Add your formula to git:

   ```bash
   git add Formula/your_software.rb
   ```

2. Commit your changes:

   ```bash
   git commit -m "Add formula for YourSoftware v1.0.0"
   ```

3. Push to the repository:

   ```bash
   git push origin main
   ```

### Step 9: Using Your Formula

Once your formula is in the tap repository, users can install it with:

```bash
brew tap yourusername/tap
brew install your_software
```

Or directly:

```bash
brew install yourusername/tap/your_software
```

## Advanced Formula Examples

### Formula with Platform-Specific Binaries

```ruby
class YourSoftware < Formula
  desc "Your cross-platform software"
  homepage "https://example.com"
  version "1.0.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://example.com/downloads/your_software-1.0.0-macos-arm64.tar.gz"
      sha256 "macos_arm_checksum"
    else
      url "https://example.com/downloads/your_software-1.0.0-macos-x86_64.tar.gz"
      sha256 "macos_intel_checksum"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://example.com/downloads/your_software-1.0.0-linux-arm64.tar.gz"
      sha256 "linux_arm_checksum"
    else
      url "https://example.com/downloads/your_software-1.0.0-linux-x86_64.tar.gz"
      sha256 "linux_intel_checksum"
    end
  end

  def install
    bin.install "your_software"
    # Install additional files if needed
    bash_completion.install "completions/your_software.bash" => "your_software"
    zsh_completion.install "completions/your_software.zsh" => "_your_software"
    man1.install "your_software.1"
  end
end
```

### Formula with Optional Dependencies

```ruby
class YourSoftware < Formula
  desc "Your software with optional features"
  homepage "https://example.com"
  url "https://example.com/your_software-1.0.0.tar.gz"
  sha256 "checksum"

  depends_on "openssl"
  depends_on "python" => :optional
  depends_on "postgresql" => :optional

  def install
    args = std_configure_args
    args << "--with-python" if build.with? "python"
    args << "--with-postgresql" if build.with? "postgresql"

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
```

## Updating Your Formula

When a new version of your software is released:

1. Update the `url` and `version` in your formula
2. Generate a new SHA-256 checksum
3. Test the updated formula
4. Commit and push the changes

## Resources

- [Homebrew Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- [Homebrew Ruby API Documentation](https://rubydoc.brew.sh/)
- [Homebrew Formula Best Practices](https://docs.brew.sh/Acceptable-Formulae)
- [Homebrew Tap Documentation](https://docs.brew.sh/Taps)
