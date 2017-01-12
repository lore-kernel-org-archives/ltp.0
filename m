From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 12 Jan 2017 03:33:15 -0500 (EST)
Subject: [LTP] [RFC] [PATCH] safe_macros: Add fallback pwrite() and
 pread() declarations
In-Reply-To: <20170111144126.GA9518@rei.lan>
References: <20170102154707.GA30109@rei.lan> <20170111144126.GA9518@rei.lan>
Message-ID: <1178986959.1715131.1484209995886.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Sent: Wednesday, 11 January, 2017 3:41:26 PM
> Subject: Re: [LTP] [RFC] [PATCH] safe_macros: Add fallback pwrite() and pread() declarations
> 
> Hi!
> I was thinking about this, and I think that we should rather go with a
> safer approach, i.e. moving the safe_pread/safe_pwrite into a separate
> header. Something as the following patch.

+1 for safer approach, I didn't know about glibc macros.
Does this affect oldlib too?

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
> 
> [Text
> Documents:0001-safe_macros-Move-SAFE_PREAD-and-SAFE_PWRITE-to-separ.patch]
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: text/x-diff
Size: 6083 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170112/b53422cd/attachment-0001.diff>
