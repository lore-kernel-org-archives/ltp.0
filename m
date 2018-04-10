From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Apr 2018 10:54:20 +0200
Subject: [LTP] [PATCH 1/1] commands: Remove outdated sssd command
In-Reply-To: <20180410084912.14695-1-schlad@suse.de>
References: <20180410084912.14695-1-schlad@suse.de>
Message-ID: <20180410085420.GC23143@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These test were never working for me hence I vote for the removal.

>  testcases/commands/sssd/Makefile    |  25 -----
>  testcases/commands/sssd/sssd-lib.sh | 189 -------------------------------
>  testcases/commands/sssd/sssd01      | 143 ------------------------
>  testcases/commands/sssd/sssd02      |  75 -------------
>  testcases/commands/sssd/sssd03      | 217 ------------------------------------

Here as well, the runtest entries have been left behind.

-- 
Cyril Hrubis
chrubis@suse.cz
