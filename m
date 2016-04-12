From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 12 Apr 2016 04:29:33 -0400 (EDT)
Subject: [LTP] Pre-release LTP build
In-Reply-To: <20160411172305.GC3466@rei.lan>
References: <20160411172305.GC3466@rei.lan>
Message-ID: <1944071328.394698.1460449773165.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Sent: Monday, 11 April, 2016 7:23:05 PM
> Subject: [LTP] Pre-release LTP build
> 
> Hi!
> I've tried to build LTP source for several distributions and as I
> expected the support for compiler atomic operations is missing in old
> compilers. Particulary gcc-4.1 on x86 (32bit RHEL5) and gcc-3.4 (SLES9)
> and older which were released in 2007 and 2006.
> 
> The questions is: do we care enough to provide fallback inline assembler?
> 
> I would be inclined to say that we don't. So does anybody out there
> still uses LTP with a compiler old enough that it does not support
> atomic builtins?

I do. At least RHEL5.6 is going to be around for another year.

I have repeatedly built your patch-series on RHEL5.6 x86_64, which works
fine. But as you pointed out 32bit version fails, other arches possibly too.

My first thought was some kind of lock, so we don't have to care
about each architecture separately.
