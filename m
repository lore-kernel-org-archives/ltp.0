From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 25 Jan 2021 13:23:28 +0100
Subject: [LTP] [PATCH] semctl09: Fix EPERM warning in cleanup()
In-Reply-To: <20210125114121.1368-1-mdoucha@suse.cz>
References: <20210125114121.1368-1-mdoucha@suse.cz>
Message-ID: <YA64QLg+xwEIwT7P@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> If semctl09 failed in one of the SAFE_*() functions during unprivileged user
> test case, SAFE_SEMCTL() in cleanup() would fail with EPERM because the sem_id
> is owned by root. Make sure that cleanup() always runs with root EUID.

Thanks a lot, merged!

Kind regards,
Petr
