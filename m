From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 12 Sep 2017 10:11:32 +0200
Subject: [LTP] [PATCH 1/2] mem: ksm: fix volatile page false positive
In-Reply-To: <20170825083427.25745-2-aarcange@redhat.com>
References: <20170825083427.25745-1-aarcange@redhat.com>
 <20170825083427.25745-2-aarcange@redhat.com>
Message-ID: <87wp54z68b.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Andrea Arcangeli writes:

> +	/*
> +	 * The current scan is already in progress so we wouldn't
> +	 * guarantee to call get_user_pages() on every existing
> +	 * rmap_item if we only waited the remaining part of the
> +	 * current scan.

Only a minor nit, but the wording is a bit unnatural here, it should
probably be: "... in progress so we can't guarantee that
get_user_pages() is is called on every existing rmap_item if ..."

> +	 *
> +	 * The actual merging happens after the unstable tree has been
> +	 * built so we need to wait at least two full scans to
> +	 * guarantee merging, so wait full_scans to increment by 3 so
> +	 * at least two full scans will run.
> +	 */

--
Thank you,
Richard.
