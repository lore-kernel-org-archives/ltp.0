From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Dec 2020 11:03:27 +0100
Subject: [LTP] [PATCH V2 2/3] syscalls: init_module: Add tests
In-Reply-To: <50d28b5f804ee13cf4efca28cbd0b2d08929d46a.1608189944.git.viresh.kumar@linaro.org>
References: <b48115a8d6dc3036f08e0166332035fab078b34a.1608189944.git.viresh.kumar@linaro.org>
 <50d28b5f804ee13cf4efca28cbd0b2d08929d46a.1608189944.git.viresh.kumar@linaro.org>
Message-ID: <X9ss72KD3nyaxLbW@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with two small fixes, thanks.

* Added dummy call to tst_module_exists() to the setup()s
  which causes the test to exit with TCONF if the module wasn't build
  for example when kernel devel package wasn't installed

* Cleaned up a bit the init_module02.c run() function

-- 
Cyril Hrubis
chrubis@suse.cz
