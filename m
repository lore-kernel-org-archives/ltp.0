From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 4 May 2021 16:33:34 +0200
Subject: [LTP] [PATCH] mtest05/mmstress: fix writes operation logic
In-Reply-To: <20210430143505.3267-1-cristian.marussi@arm.com>
References: <20210430143505.3267-1-cristian.marussi@arm.com>
Message-ID: <YJFbPoV6tkmVExa5@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	size_t written = 0;

I've changed this to ssize_t in order to avoid signed vs unsigned
comparsion warning and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
