From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 7 Oct 2019 15:19:30 -0400 (EDT)
Subject: [LTP] [PATCH] Update dynamic_debug grep check
In-Reply-To: <20191007140321.GA23368@rei.lan>
References: <20191004184436.30922-1-rasibley@redhat.com>
 <20191007140321.GA23368@rei.lan>
Message-ID: <1688136841.4982944.1570475970464.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "rasibley" <rasibley@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Monday, 7 October, 2019 4:03:21 PM
> Subject: Re: [LTP] [PATCH] Update dynamic_debug grep check
> 
> Hi!
> > If running on debug kernel this check will fail on EDAC DEBUG messages,
> > update grep to ignore such cases like this.
> 
> You are missing the Signed-off-by: line here, see:
> 
> https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#developer-s-certificate-of-origin-1-1

You can also use kernel scripts/checkpatch.pl.

> 
> Otherwise the patch is Ok.

Pushed with added Signed-off-by and tweaked commit message.

Thanks,
Jan
