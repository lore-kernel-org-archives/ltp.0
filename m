From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 12 Apr 2016 07:57:59 -0400 (EDT)
Subject: [LTP] Pre-release LTP build
In-Reply-To: <20160412084049.GA24915@rei.lan>
References: <20160411172305.GC3466@rei.lan>
 <1944071328.394698.1460449773165.JavaMail.zimbra@redhat.com>
 <20160412084049.GA24915@rei.lan>
Message-ID: <1180846583.442810.1460462279148.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Tuesday, 12 April, 2016 10:40:49 AM
> Subject: Re: [LTP] Pre-release LTP build
> 
> Hi!
> > I do. At least RHEL5.6 is going to be around for another year.
> > 
> > I have repeatedly built your patch-series on RHEL5.6 x86_64, which works
> > fine. But as you pointed out 32bit version fails, other arches possibly
> > too.
> > 
> > My first thought was some kind of lock, so we don't have to care
> > about each architecture separately.
> 
> I think that easiest solution would be copying the assembler the builtin
> produces and using it as a fallback. That would have to be done per
> arch, but the rest of the code could be left untouched.

As for RHEL5.6 it's only i386. I was able to compile x86_64, ia64, ppc/ppc64
and s390/s390x with no changes.

Any of these two allow it to compile on x86:
1. -march=i486 (or higher)
2.
diff --git a/lib/tst_atomic.c b/lib/tst_atomic.c
new file mode 100644
index 0000000..601fd6c
--- /dev/null
+++ b/lib/tst_atomic.c
@@ -0,0 +1,8 @@
+#if defined(__i386__)
+unsigned int __sync_add_and_fetch_4(unsigned int *v, unsigned value)
+{
+       register int val = value;
+       __asm__ __volatile__ ( "lock xadd %1,%0" : "=m" (*v), "=r" (val) : "1" (val) : "memory");
+       return val + value;
+}
+#endif

According to gcc docs it should only make external call to above function,
when it's not provided natively, so it works as fallback.
