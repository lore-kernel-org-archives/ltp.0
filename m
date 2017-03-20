From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 20 Mar 2017 12:11:28 +0100
Subject: [LTP] Access02 and use of system() library function
In-Reply-To: <beacb487-181d-2d9c-380a-128b985b2250@gezedo.com>
References: <beacb487-181d-2d9c-380a-128b985b2250@gezedo.com>
Message-ID: <20170320111128.GA3322@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> in order to check the actual executable mode of a file, access02 calls system() library function.
> 
> The test fails when the return value of system() is not 0. Shouldn't the return value being tested only for its sign instead (and even versus -1 only) ?
> 
> The system() function returns -1 in case of error, and the return value of the command otherwise. Even in the case the command returns non-zero value, its execution is positively checked, but access02 fails because the return value is not 0.
> 
> This corner case happens when the shell is busybox's hush. Hush uses execvp to execute the test_file3, this leads the kernel to return ENOEXEC (bad exec format). Then execvp tries to execute the shell "/bin/sh" with the name of the file "./test_file3" as argv[0]. Then busybox returns that no such an applet does exist, and terminates with error code 127.

What LTP version is this? The access02 test was rewritten some time ago and
there is no test_file3 since commit:

commit adb3e23d9de5f8ff54d2395112f79f25c36cf598
Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date:   Wed Jul 20 18:44:39 2016 +0800

    syscalls/access02: reconstruct and convert to new API

Which is included in last to stable releases....

-- 
Cyril Hrubis
chrubis@suse.cz
