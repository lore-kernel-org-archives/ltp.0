From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 Dec 2020 13:55:27 +0100
Subject: [LTP] [PATCH] module.mk: Remove .mod files as well during make
 clean
In-Reply-To: <9dcf930c32cfa30d683e56d368c094367695d733.1608100564.git.viresh.kumar@linaro.org>
References: <9dcf930c32cfa30d683e56d368c094367695d733.1608100564.git.viresh.kumar@linaro.org>
Message-ID: <X9oDvzZGd5okFZy1@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed, thanks.

Also for me the module build generates build-in.a as well. I guess that
we should add that one to .gitignore and clean it up on make clean as
well.

-- 
Cyril Hrubis
chrubis@suse.cz
