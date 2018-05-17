From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 17 May 2018 18:20:48 +0800
Subject: [LTP] [PATCH] read_all: Drop privileges
In-Reply-To: <20180516114438.GA26490@rei>
References: <20180515095118.26282-1-rpalethorpe@suse.com>
 <20180515103042.GB7220@rei> <87bmdhyyrf.fsf@rpws.prws.suse.cz>
 <5AFBFC35.3060400@cn.fujitsu.com> <20180516114438.GA26490@rei>
Message-ID: <5AFD5780.7040107@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2018/05/16 19:44, Cyril Hrubis wrote:
> Hi!
>> If the permission of /dev/watchdog was 0660(default permission on RHEL6), Reading /dev/watchdog as nobody
>> user failed, but still led to system reboot.
> If unprivileged user can reboot the system it's a bug.
Hi Cyril,

Sorry, it seems a bug in open(2) instead of watchdog.

You can reproduce the issue by running the following test.c:
----------------------------------------------------------------------------------------------------------
#include <errno.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <pwd.h>
#include <unistd.h>
#include <stdlib.h>

static void switch_privs(void)
{
         struct passwd *nobody;
         int ret;

         nobody = getpwnam("nobody");
         if (nobody == NULL) {
                 printf("getpwnam(nobody) failed with errno %d\n", errno);
                 exit(1);
         }

         ret = setgid(nobody->pw_gid);
         if (ret < 0) {
                 printf("Failed to use nobody gid with errno %d\n", errno);
                 exit(1);
         }

         ret = setuid(nobody->pw_uid);
         if (ret < 0) {
                 printf("Failed to use nobody uid with errno %d\n", errno);
                 exit(1);
         }
}

int main(void)
{
         int fd;

         umask(0);

         fd = open("testfile", O_RDWR | O_CREAT, 0660);
         if (fd < 0) {
                 printf("open(testfile) failed with errno %d\n", errno);
                 return 1;
         }

         close(fd);

         switch_privs();

         fd = open("testfile", O_RDWR);
         if (fd < 0) {
                 printf("open(testfile) failed with errno %d\n", errno);
                 return 1;
         }

         printf("open(testfile) succeeded unexpectedly\n");

         close(fd);
}
------------------------------------------------------------------------------------------------------------
# gcc -o test test.c
# ./test
open(testfile) succeeded unexpectedly

We created a test file with 0660 mode as root user, and opened the test 
file as nobody user switched by setuid() and setgid().
Running this test got success rather than EACCES.  Do you think this is 
a bug or i misunderstand the permissions of file?

Thanks,
Xiao Yang



