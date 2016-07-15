From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 15 Jul 2016 11:55:31 +0200
Subject: [LTP] [PATCH] consolidate 4 TCs message_queue_test_02_* into
 message_queue_test_02.sh to avoid fail in case of random execution
In-Reply-To: <1468576023-32754-1-git-send-email-nga.hoangthithuy@vn.bosch.com>
References: <1468576023-32754-1-git-send-email-nga.hoangthithuy@vn.bosch.com>
Message-ID: <20160715095531.GA3268@rei.scz.novell.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/runtest/ipc b/runtest/ipc
> index 50f072a..7c6fed5 100644
> --- a/runtest/ipc
> +++ b/runtest/ipc
> @@ -32,10 +32,7 @@ sem01 sem01
>  sem02 sem02
>  
>  message_queue_test_01		message_queue_test_01
> -message_queue_test_02_get	message_queue_test_02_get
> -message_queue_test_02_snd	message_queue_test_02_snd
> -message_queue_test_02_rcv	message_queue_test_02_rcv
> -message_queue_test_02_ctl	message_queue_test_02_ctl -r
> +message_queue_test_02		message_queue_test_02.sh
>  message_queue_test_04		message_queue_test_04
>  message_queue_test_05		message_queue_test_05
>  pipe_test_01			pipe_test_01

This is exactly against our guidelines, see:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#211-runtest-files

-- 
Cyril Hrubis
chrubis@suse.cz
