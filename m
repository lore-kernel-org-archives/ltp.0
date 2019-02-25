From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Feb 2019 16:22:38 +0100
Subject: [LTP] [PATCH v4 2/9] lib: split tst_fill_file() to create new
 tst_fill_fd()
In-Reply-To: <1550739616-24054-3-git-send-email-sumit.garg@linaro.org>
References: <1550739616-24054-1-git-send-email-sumit.garg@linaro.org>
 <1550739616-24054-3-git-send-email-sumit.garg@linaro.org>
Message-ID: <20190225152238.GC6132@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Ideally these two functions should be noted in the
test-writing-guidelines.txt as well.

-- 
Cyril Hrubis
chrubis@suse.cz
