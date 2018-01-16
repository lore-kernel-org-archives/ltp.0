From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Jan 2018 11:32:31 +0100
Subject: [LTP] [PATCH v2] syscalls/madvise09.c: Use custom mount point
 instead of /sys/fs/cgroup/memory
In-Reply-To: <5A5DC3A5.1030604@cn.fujitsu.com>
References: <5A4D94E0.4030508@cn.fujitsu.com>
 <1515033797-18823-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <5A5C3E27.1050702@cn.fujitsu.com>
 <1801982516.6465238.1516003561998.JavaMail.zimbra@redhat.com>
 <5A5C7411.9040107@cn.fujitsu.com>
 <2055444592.6673123.1516031934917.JavaMail.zimbra@redhat.com>
 <5A5DC1C3.2020203@cn.fujitsu.com> <5A5DC3A5.1030604@cn.fujitsu.com>
Message-ID: <20180116103231.GA24595@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Adding Cyril to CC.  :-)

I guess that it's time to create some kind of libary API for
initializing cgroups since we have various fallbacks etc. scattered all
around the place. I.e. something where we request the type of cgroup and
get back a path to use.

Let's look into that once we are done with the release.

-- 
Cyril Hrubis
chrubis@suse.cz
