From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 2 Nov 2018 16:34:53 +0100
Subject: [LTP] [PATCH v3 1/6] syscalls/readahead01: Convert to newlib
In-Reply-To: <20181010233441.5337-2-amir73il@gmail.com>
References: <20181010233441.5337-1-amir73il@gmail.com>
 <20181010233441.5337-2-amir73il@gmail.com>
Message-ID: <20181102153453.GB30704@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes:

* close() -> SAFE_CLOSE()

* Changed the check_* functions to void since we do not use the returned
  value

* Removed .needs_root = 1 since the test isn't doing anything priviledged

Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
