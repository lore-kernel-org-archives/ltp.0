From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Jun 2021 15:29:38 +0200
Subject: [LTP] [PATCH v4 3/3] API: Remove TST_ERR usage from
 rtnetlink/netdevice
In-Reply-To: <20210615074045.23974-3-rpalethorpe@suse.com>
References: <20210615074045.23974-1-rpalethorpe@suse.com>
 <20210615074045.23974-3-rpalethorpe@suse.com>
Message-ID: <YMirQoiYRYsDP7Sb@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The test author is guaranteed that the library will not set TST_ERR
> except via the TEST macro and similar.
> 
> Currently the rtnetlink & netdevice API returns 0 on fail and 1 on
> success. Either TST_ERR or errno is used to store the error
> number. The commit stays with this scheme except that we only use
> errno. This means that we have to temporarily save errno when it would
> be overwritten by a less important operation.

I do not like this fix. If nothing else it's fragile and would make any
patch review for these libraries much harder.

I would prefer having these functions modified to return the errors
instead even if I have to do the work.

-- 
Cyril Hrubis
chrubis@suse.cz
