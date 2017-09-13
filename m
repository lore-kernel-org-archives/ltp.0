From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Sep 2017 13:58:27 +0200
Subject: [LTP] [PATCH 1/2] mem: ksm: fix volatile page false positive
In-Reply-To: <20170825083427.25745-2-aarcange@redhat.com>
References: <20170825083427.25745-1-aarcange@redhat.com>
 <20170825083427.25745-2-aarcange@redhat.com>
Message-ID: <20170913115827.GA27706@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	/*
> +	 * The current scan is already in progress so we wouldn't
> +	 * guarantee to call get_user_pages() on every existing
> +	 * rmap_item if we only waited the remaining part of the
> +	 * current scan.
> +	 *
> +	 * The actual merging happens after the unstable tree has been
> +	 * built so we need to wait at least two full scans to
> +	 * guarantee merging, so wait full_scans to increment by 3 so
> +	 * at least two full scans will run.
> +	 */

I've took a liberty in rewording this comment a bit and pushed the
patchset, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
