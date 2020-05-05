From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 5 May 2020 04:58:15 -0400 (EDT)
Subject: [LTP] [bug?] clone(CLONE_IO) failing after kernel commit commit
 ef2c41cf38a7
In-Reply-To: <20200505083205.qwwdiotmmjl23aje@wittgenstein>
References: <1038674044.11248021.1588663714272.JavaMail.zimbra@redhat.com>
 <87pnbi4y8x.fsf@mid.deneb.enyo.de>
 <20200505083205.qwwdiotmmjl23aje@wittgenstein>
Message-ID: <195377888.11254757.1588669095248.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> (Btw, iiuc, this would've always been a problem, right? In the sense that
> userspace only got away with this because there were no additional flags
> defined and couldn't.)

I think so, 4.20 behaves same way, but kernel ignores any extra flags:
  clone(child_stack=0x1011ffe0, flags=CLONE_IO|0xffffffff00000000|SIGCHLD) = 1061

