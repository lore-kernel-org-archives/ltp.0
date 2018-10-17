From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 17 Oct 2018 21:48:37 +0200
Subject: [LTP] [PATCH] tracing/intel_pt: Fix build on older userspace.
In-Reply-To: <20181017153833.27187-1-chrubis@suse.cz>
References: <20181017153833.27187-1-chrubis@suse.cz>
Message-ID: <20181017194837.GA1215@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Older userspace linux headers do not have aux_* fields struct
> perf_event_mmap_page. This commit disables the test build if older
> headers were detected, the alternative would be adding a fallback
> definition to LTP but I doubt that it's worth the effort.

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Ammy Yi <ammy.yi@intel.com>

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks for fixing it.

Kind regards,
Petr
