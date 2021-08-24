From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 Aug 2021 16:02:02 +0200
Subject: [LTP] [PATCH] syscalls/sync_file_range01: Convert to new API
In-Reply-To: <20210817011431.10648-1-sujiaxun@uniontech.com>
References: <20210817011431.10648-1-sujiaxun@uniontech.com>
Message-ID: <YST72qTrmOf+d3Ej@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with two minor changes, thanks.

- rewrote the test description a bit
- changed the TST_EXP_FAIL() to print nicer message

-- 
Cyril Hrubis
chrubis@suse.cz
