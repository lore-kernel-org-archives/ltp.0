From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 30 Jan 2017 09:25:38 +0100
Subject: [LTP] Running LTP on new filesystems
In-Reply-To: <A8370F49-367D-4A04-BC93-A485ECFA42F7@eng.ucsd.edu>
References: <A8370F49-367D-4A04-BC93-A485ECFA42F7@eng.ucsd.edu>
Message-ID: <20170130082538.GA29227@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I am trying to run LTP on a new filesystem and am stuck in figuring out the right way to do this.
> 
> Specifically, if I have mounted my file system at /mnt/new-fs, I want to use this directory as mount point for all the filesystem tests.
> I tried running by specifying this as the  -d TMPDIR  option ( -d /mnt/new-fs in runltp ) but I am not sure if this is the right way.

This is exactly what I would have done. Most of the testcases uses
TMPDIR as a base for any temporary files and so all fs related syscalls
will end up in the right filesystem code.

There are a few testscases that use a device for testing and make
filesystem there. You have to export *FS_DEV_TYPE env variables (see
runltp -h), otherwise these default to ext2.

> I don???t see any specific instructions on how to run LTP on new
> filesystems.  It will be a great help if someone points out the right
> way to do this or any documentation that might help.

Sorry, we are a bit underdocumented in that area.

-- 
Cyril Hrubis
chrubis@suse.cz
