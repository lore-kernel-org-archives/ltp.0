From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 1 Apr 2021 09:22:26 +0200
Subject: [LTP] [PATCH] crypto_user02: Find a valid template
In-Reply-To: <YGIiE5/DnjXrcHzK@gmail.com>
References: <20210315130349.1155389-1-lkml@jv-coder.de>
 <YGIiE5/DnjXrcHzK@gmail.com>
Message-ID: <YGV0sj+X+3AICZiY@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg, Eric,

Implemented all Eric's suggestions and merged.
Thank you both!

> > +	if (!template) {
> > +		tst_brk(TCONF, "No viable template found");
> > +	}

> Single-line statements shouldn't have braces like this.
Oops, left this one, fixed in separated commit :(.

Kind regards,
Petr
