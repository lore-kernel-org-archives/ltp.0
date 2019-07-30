From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 30 Jul 2019 13:05:55 +0200
Subject: [LTP] [PATCH v6 1/3] lib: alter find_free_loopdev()
In-Reply-To: <5D401F02.5080209@cn.fujitsu.com>
References: <5D30200B.4050306@cn.fujitsu.com>
 <1564030915-3211-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190729130107.GA27006@rei.lan> <5D401F02.5080209@cn.fujitsu.com>
Message-ID: <20190730110555.GB7528@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +                       if (path != NULL)
> +                               strcpy(path, buf);

This should be at least strncpy() since we have the path length, or we
may as well call set_dev_path(rc, path, path_len) here.

-- 
Cyril Hrubis
chrubis@suse.cz
