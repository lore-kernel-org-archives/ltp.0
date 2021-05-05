From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 5 May 2021 16:59:24 +0200
Subject: [LTP] [PATCH v3 2/4] bpf: Add map_array helper functions/macro
 and constify
In-Reply-To: <20210505091623.29121-3-rpalethorpe@suse.com>
References: <20210505091623.29121-1-rpalethorpe@suse.com>
 <20210505091623.29121-3-rpalethorpe@suse.com>
Message-ID: <YJKyzGfV/PlEWWlL@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	const int ret = bpf(BPF_MAP_LOOKUP_ELEM, &elem_attr, sizeof(elem_attr));
> +
> +        if (ret) {

Fixed these spaces wrongly used for indentation.

> +		tst_brk(TBROK | TTERRNO,
> +			"Failed array map lookup: [%"PRIu32, *array_indx);

And also this message. There was missing ] at the end of the string and
I've also added the fd=%i to the message as well.

And pushed along with the rest of the patchset, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
