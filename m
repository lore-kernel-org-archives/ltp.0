From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 14 Jul 2021 13:21:13 +0200
Subject: [LTP] [PATCH v2 7/8] API: Move libtsc.h from realtime tests
 include to tst_tsc.h
In-Reply-To: <20210714071158.15868-8-rpalethorpe@suse.com>
References: <20210714071158.15868-1-rpalethorpe@suse.com>
 <20210714071158.15868-8-rpalethorpe@suse.com>
Message-ID: <YO7IqecaXFwjvHQn@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

> Allow the meltdown test to use this file without modifying the
> CFLAGS. This avoids having to add the include also to the CHECK_FLAGS.
+1

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
