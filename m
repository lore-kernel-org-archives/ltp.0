From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 29 Mar 2016 09:50:18 -0400 (EDT)
Subject: [LTP] [PATCH] readahead: use glibc wrapper function
In-Reply-To: <20160329125729.GB14139@rei.suse.cz>
References: <27e9eeb52d71394f8df405f98e66ffccec83803c.1458833602.git.jstancek@redhat.com>
 <20160329125729.GB14139@rei.suse.cz>
Message-ID: <502563602.15093338.1459259418762.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it, "Kshitij Malik" <Kshitij.Malik@mitel.com>
> Sent: Tuesday, 29 March, 2016 2:57:29 PM
> Subject: Re: [LTP] [PATCH] readahead: use glibc wrapper function
> 
> Hi!
> > We have had reports of this testcase not functioning
> > properly on 32bit powerpc systems, because syscall()
> > is not passing 64bit parameters correctly.
> > 
> > This patch is using glibc wrapper, which should be available
> > for a long time now (since glibc 2.3).
> 
> Looks good to me, acked.

Pushed.

Regards,
Jan
