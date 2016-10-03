From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 3 Oct 2016 08:02:40 -0400 (EDT)
Subject: [LTP] [PATCH] Fix sync_file_range for Mips
In-Reply-To: <1475492806-9443-1-git-send-email-dejan.jovicevic@rt-rk.com>
References: <1475492806-9443-1-git-send-email-dejan.jovicevic@rt-rk.com>
Message-ID: <914589421.106693.1475496160136.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Dejan Jovicevic" <dejan.jovicevic@rt-rk.com>
> To: ltp@lists.linux.it
> Sent: Monday, 3 October, 2016 1:06:46 PM
> Subject: [LTP]  [PATCH] Fix sync_file_range for Mips
> 
> For Mips there is a second argument which is actually a padding.
> This can be confirmed in glibc.

<glibc>/sysdeps/unix/sysv/linux/mips/mips32/sync_file_range.c or [1]:

    LONG LONG in 32-bit mode:
	If GR > r10, go to STACK.  Otherwise, if GR is odd, advance
	GR to the next register.  Load the 64-bit long long value into
	register pair GR and GR+1.  Advance GR to GR+2 and go to SCAN.

Pushed with slightly modified commit message. Please include
Signed-off-by line in future.

Thanks,
Jan

[1] http://www.cygwin.com/ml/binutils/2003-06/msg00436.html
