From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 May 2018 10:45:58 +0200
Subject: [LTP] [PATCH] cve-2017-16939: drop linux/xfrm.h include
In-Reply-To: <d54cb909eacb6c2fe6b11f7e187862ef3070499c.1524739878.git.jstancek@redhat.com>
References: <d54cb909eacb6c2fe6b11f7e187862ef3070499c.1524739878.git.jstancek@redhat.com>
Message-ID: <20180503084558.GD29568@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#ifndef __XFRM_H__
> +#define __XFRM_H__

I tend to avoid double underscores in identifier names, since these are
reserved for libc, so I would have named this LAPI_XFRM_H__ or something
similar, but that is very minor.

Other than that acked.

-- 
Cyril Hrubis
chrubis@suse.cz
