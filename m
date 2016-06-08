From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Jun 2016 16:23:45 +0200
Subject: [LTP] [PATCH] Shell wrappers for the checkpoint interface
In-Reply-To: <1465379944-21713-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1465379944-21713-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160608142344.GD27367@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	if (!type)
> +		ret = tst_checkpoint_wait(id, timeout);
> +	else
> +		ret = tst_checkpoint_wake(id, nr_wake, timeout);

I find it silly that you do negate the flag here. You could have set it
the other way, or swap the wait and wake in the if and else branch...

Anyway the rest looks good to me, ackend.

-- 
Cyril Hrubis
chrubis@suse.cz
