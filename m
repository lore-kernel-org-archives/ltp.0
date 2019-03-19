From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Mar 2019 14:54:54 +0100
Subject: [LTP] [PATCH v3 0/3] syscalls: add tgkill test-cases
In-Reply-To: <1552978181-27748-1-git-send-email-sumit.garg@linaro.org>
References: <1552978181-27748-1-git-send-email-sumit.garg@linaro.org>
Message-ID: <20190319135454.GG6204@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

Also we are still missing the EPERM error case, for that we would have
to start the test as root, fork a child change the UID and GID and
attempt to send a signal to parent process.

-- 
Cyril Hrubis
chrubis@suse.cz
