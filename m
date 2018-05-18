From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 18 May 2018 19:09:33 +0200
Subject: [LTP] [PATCH] read_all: Drop privileges
In-Reply-To: <5AFD5780.7040107@cn.fujitsu.com>
References: <20180515095118.26282-1-rpalethorpe@suse.com>
 <20180515103042.GB7220@rei> <87bmdhyyrf.fsf@rpws.prws.suse.cz>
 <5AFBFC35.3060400@cn.fujitsu.com> <20180516114438.GA26490@rei>
 <5AFD5780.7040107@cn.fujitsu.com>
Message-ID: <20180518170933.GA5094@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Sorry, it seems a bug in open(2) instead of watchdog.

Looks like the list of supplementary groups is at fault here.

On my system I do have in /etc/group:

root:x:0:root

Which means that among other groups root has root suplementary group set
when logged in.

Which means that even when a program sets it's user and group ids to
nobody the root still stays in the list of supplementary groups, which
then is matched for files with root group ownership and hence we can
stil open the file.

Adding setgroups(0, NULL); to switch_privs() in your program "fixes" the
behavior and we get EPERM as expected. And I guess that we should patch
the read_all to do the same, which should fix your problem. I will apply
the fix.

-- 
Cyril Hrubis
chrubis@suse.cz
