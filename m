From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 3 May 2018 05:45:04 -0400 (EDT)
Subject: [LTP] [PATCH] cve-2017-16939: drop linux/xfrm.h include
In-Reply-To: <20180503084558.GD29568@rei>
References: <d54cb909eacb6c2fe6b11f7e187862ef3070499c.1524739878.git.jstancek@redhat.com>
 <20180503084558.GD29568@rei>
Message-ID: <207855739.17189074.1525340704156.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > +#ifndef __XFRM_H__
> > +#define __XFRM_H__
> 
> I tend to avoid double underscores in identifier names, since these are
> reserved for libc, so I would have named this LAPI_XFRM_H__ or something
> similar, but that is very minor.
> 
> Other than that acked.

Pushed with suggested change.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
