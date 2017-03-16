From: Laurent GONZALEZ <ltp@gezedo.com>
Date: Thu, 16 Mar 2017 15:04:12 +0100
Subject: [LTP] Access02 and use of system() library function
Message-ID: <beacb487-181d-2d9c-380a-128b985b2250@gezedo.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi list,

in order to check the actual executable mode of a file, access02 calls system() library function.

The test fails when the return value of system() is not 0. Shouldn't the return value being tested only for its sign instead (and even versus -1 only) ?

The system() function returns -1 in case of error, and the return value of the command otherwise. Even in the case the command returns non-zero value, its execution is positively checked, but access02 fails because the return value is not 0.

This corner case happens when the shell is busybox's hush. Hush uses execvp to execute the test_file3, this leads the kernel to return ENOEXEC (bad exec format). Then execvp tries to execute the shell "/bin/sh" with the name of the file "./test_file3" as argv[0]. Then busybox returns that no such an applet does exist, and terminates with error code 127.

Thanks for comments.



