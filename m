From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 20 Jun 2017 09:02:03 -0400 (EDT)
Subject: [LTP] [PATCH v2] syscalls: Add timer measurement library
In-Reply-To: <20170620123358.GD5369@rei.lan>
References: <20170614124239.21109-1-chrubis@suse.cz>
 <88192643.36961651.1497621378847.JavaMail.zimbra@redhat.com>
 <20170620114951.GC5369@rei.lan> <20170620123358.GD5369@rei.lan>
Message-ID: <1215902010.40140214.1497963723219.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Tuesday, 20 June, 2017 2:33:58 PM
> Subject: Re: [LTP] [PATCH v2] syscalls: Add timer measurement library
> 
> Hi!
> What about this patch:
> 
> From 5cc450f19eb526cb19c33f4f13796e3c2a6f0bff Mon Sep 17 00:00:00 2001
> From: Cyril Hrubis <chrubis@suse.cz>
> Date: Tue, 20 Jun 2017 14:33:59 +0200
> Subject: [PATCH] Fix clock_gettime linking problems.
> 

Works for me. Nothing else comes to my mind, either syscalls
or linking everything with -rt.

Only potential issue I can think of is parameter padding needed
in syscall() for some architectures with 32-bit userspace.
With clockid_t defined as int, I think we should be fine.

Regards,
Jan
