From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 15 Aug 2018 16:01:46 +0200
Subject: [LTP] [PATCH v3 ltp 4/4] fs/ext4: update format and fix typo
In-Reply-To: <20180726092219.15667-4-yixin.zhang@intel.com>
References: <20180726092219.15667-1-yixin.zhang@intel.com>
 <20180726092219.15667-4-yixin.zhang@intel.com>
Message-ID: <20180815140146.GA14551@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  	if [ $nsec_atime -ne $nsec_atime2 -o $nsec_ctime -ne $nsec_ctime2 -o \
> -	     $nsec_mtime -ne $nsec_mtime2 ]; then
> +			$nsec_mtime -ne $nsec_mtime2 ]; then

I've remove this change from the patch, since it looks like a mistake
and pushed the whole patchset, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
