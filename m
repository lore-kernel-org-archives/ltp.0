From: Andreas Schwab <schwab@linux-m68k.org>
Date: Tue, 05 May 2020 09:54:38 +0200
Subject: [LTP] [bug?] clone(CLONE_IO) failing after kernel commit commit
 ef2c41cf38a7
In-Reply-To: <1038674044.11248021.1588663714272.JavaMail.zimbra@redhat.com>
 (Jan Stancek via Libc-alpha's message of "Tue, 5 May 2020 03:28:34
 -0400 (EDT)")
References: <100149681.11244932.1588661282331.JavaMail.zimbra@redhat.com>
 <1038674044.11248021.1588663714272.JavaMail.zimbra@redhat.com>
Message-ID: <874ksuke9t.fsf@igel.home>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mai 05 2020, Jan Stancek via Libc-alpha wrote:

> I'm seeing an issue with CLONE_IO and libc' clone() on ppc64le,
> where flags parameter appears to be sign extended before it's passed
> to kernel syscall.

Looks like the flags argument should be declared as unsigned int,
instead of int, both in glibc and in the kernel.

#define CLONE_IO		0x80000000	/* Clone io context */

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
