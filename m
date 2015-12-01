From: Jeffrey Bastian <jbastian@redhat.com>
Date: Tue, 1 Dec 2015 11:10:23 -0600
Subject: [LTP] [PATCH] Fix wrong pattern used by fnmatch in test case
 proc01.c
In-Reply-To: <565D69AA.1030604@huawei.com>
References: <1448606649-141790-1-git-send-email-King.lijin@huawei.com>
 <1448606649-141790-2-git-send-email-King.lijin@huawei.com>
 <733187539.20734579.1448887572067.JavaMail.zimbra@redhat.com>
 <565CF833.4070101@huawei.com>
 <619455416.21202777.1448958949649.JavaMail.zimbra@redhat.com>
 <565D69AA.1030604@huawei.com>
Message-ID: <20151201171023.GA11288@tarantula.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Dec 01, 2015 at 05:34:34PM +0800, Lijin(Euler Dept 8) wrote:
> On 2015/12/1 16:35, Jan Stancek wrote:
> > I'm curious on what distro and glibc version original code is failing for you.
> 
> redhat RHEL 6 and /lib64/libc.so.6 - GNU C Library (GNU libc) stable release version 2.17, by Roland McGrath et al.

RHEL6 had glibc-2.12 and kernel-2.6.32, so you must have a locally built
version of glibc-2.17 and kernel-4.1?

What locale are you using?  There is an open bug about the * glob not
working on multibyte characters, and although there should not be any
multibyte characters in the /proc/sys/net/ipv6/conf/*/stable_secret
path, I wonder if this is somehow related?
  https://sourceware.org/bugzilla/show_bug.cgi?id=14185

It might be worth trying different values of $LANG and/or $LC_ALL to see
if that helps or not, especially LANG=C and LC_ALL=C.

-- 
Jeff Bastian
