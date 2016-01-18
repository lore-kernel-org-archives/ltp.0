From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 18 Jan 2016 15:50:41 +0100
Subject: [LTP] [PATCH] kernel/input: increase the number of retries in
 open_device
In-Reply-To: <1453128553-18171-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1453128553-18171-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160118145040.GA5097@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> In some environments the current limit (2) is not enough, and only
> 3rd or 4th access will succeed. Therefore, let's increase it slightly.
> The new limit (10) is the same value we have in open_uinput().

Acked. Thanks for the testing :).

-- 
Cyril Hrubis
chrubis@suse.cz
