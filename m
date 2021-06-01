From: Alexander Egorenkov <egorenar@linux.ibm.com>
Date: Tue, 01 Jun 2021 14:02:48 +0200
Subject: [LTP] [PATCH 2/2] tst_wallclock_restore: fix access time of
 /etc/localtime
In-Reply-To: <YLYVIvTBYsdE6Gzh@yuki>
References: <20210601093614.245873-1-egorenar@linux.ibm.com>
 <20210601093614.245873-2-egorenar@linux.ibm.com> <YLYVIvTBYsdE6Gzh@yuki>
Message-ID: <875yyxrdw7.fsf@oc8242746057.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi,

Cyril Hrubis <chrubis@suse.cz> writes:


> I would prefer not to break the test here if the file is not present on
> a system, there may be embedded systems where this file does not exists
> and SAFE_TOUCH() will exit the test with TBROK in that case.

Good point, thanks, fixed in v2.

>
> Also the problem is access time here, so opening and closing the file
> should be enough to fix it right?
>
> What about something as:
>
> 	int fd = open("/etc/localtime", O_RDWR);
> 	if (fd > 0)
> 		SAFE_CLOSE(fd);
>
> That should fix the access time without breaking the test on systems
> that does not have the /etc/localtime file installed.
>

According to some manpage (which i sadly don't remember) the access time of a
file never changes with just an open, one have to read some data at
least. But even reading won't help in this case, see example below
and my explanation in the patch v2.



$ stat /usr/share/zoneinfo/Europe/Berlin
  File: /usr/share/zoneinfo/Europe/Berlin
  Size: 2298            Blocks: 8          IO Block: 4096   regular file
Device: fd01h/64769d    Inode: 2623067     Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Context: system_u:object_r:locale_t:s0
Access: 2038-01-19 04:14:06.076000270 +0100    <---------- !!!
Modify: 2021-06-01 13:48:50.751160745 +0200
Change: 2021-06-01 13:48:50.751160745 +0200
 Birth: 2021-04-28 22:06:08.389017197 +0200

$ od -N1 /usr/share/zoneinfo/Europe/Berlin
0000000 000124
0000001

$ stat /usr/share/zoneinfo/Europe/Berlin
  File: /usr/share/zoneinfo/Europe/Berlin
  Size: 2298            Blocks: 8          IO Block: 4096   regular file
Device: fd01h/64769d    Inode: 2623067     Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Context: system_u:object_r:locale_t:s0
Access: 2038-01-19 04:14:06.076000270 +0100    <---------- !!!
Modify: 2021-06-01 13:48:50.751160745 +0200
Change: 2021-06-01 13:48:50.751160745 +0200
 Birth: 2021-04-28 22:06:08.389017197 +0200


Thanks for feedback
Regards
Alex
