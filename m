From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 4 Dec 2020 15:19:42 +0100
Subject: [LTP] [PATCH 4/5] syscalls/fanotify09: Add test case with two
 non-dir children
In-Reply-To: <20201204095930.866421-5-amir73il@gmail.com>
References: <20201204095930.866421-1-amir73il@gmail.com>
 <20201204095930.866421-5-amir73il@gmail.com>
Message-ID: <X8pFfjcCqnzUDomD@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> The existing test cases generate FAN_MODIFY event on a non-dir child
> and FAN_CLOSE_NOWRITE event the parent or sibling subdir.

> Add a test case that generates FAN_CLOSE_NOWRITE on a sibling non-dir
> child.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
