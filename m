From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Dec 2020 11:01:09 +0100
Subject: [LTP] [PATCH V2 1/3] tst_module: Add separate declarations of
 helpers for new tests framework
In-Reply-To: <b48115a8d6dc3036f08e0166332035fab078b34a.1608189944.git.viresh.kumar@linaro.org>
References: <b48115a8d6dc3036f08e0166332035fab078b34a.1608189944.git.viresh.kumar@linaro.org>
Message-ID: <X9ssZcxV/K405rYd@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a small fix, thanks.

It turned out that there was a typo in the old_module.h header, the
function tst_module_exist() never existed and it's supposed to be
tst_module_exists(). So I've renamed all instances accordingly.

-- 
Cyril Hrubis
chrubis@suse.cz
