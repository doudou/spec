require_relative '../../../spec_helper'

describe "File::Stat#rdev_major" do
  before :each do
    platform_is :solaris do
      @name = "/dev/zfs"
    end
    platform_is_not :solaris do
      @name = tmp("file.txt")
      touch(@name)
    end
  end

  after :each do
    platform_is_not :solaris do
      rm_r @name
    end
  end

  ruby_version_is "2.4" do
    platform_is_not :windows do
      it "returns the major part of File::Stat#rdev" do
        File.stat(@name).rdev_major.should be_kind_of(Integer)
      end
    end
  end

  platform_is :windows do
    it "returns nil" do
      File.stat(@name).rdev_major.should be_nil
    end
  end
end
