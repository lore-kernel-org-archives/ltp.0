From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 19 Mar 2021 12:52:41 +0100
Subject: [LTP] [PATCH v2] syscalls/semctl09: Skip libc test if
 SEM_STAT_ANY not defined
In-Reply-To: <20210319114349.22696-1-mdoucha@suse.cz>
References: <20210319114349.22696-1-mdoucha@suse.cz>
Message-ID: <YFSQiXkXUAUZGieS@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> The libc test variant should run only if system headers define SEM_STAT_ANY.
> Skip it if we're falling back to the LAPI definition.
Thanks a lot, merged (with also Xu Reviewed-by tag).

Kind regards,
Petr
