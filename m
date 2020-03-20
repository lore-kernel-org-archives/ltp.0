From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 20 Mar 2020 17:04:09 +0100
Subject: [LTP] [PATCH V3 2/2] syscalls/clone3: New tests
In-Reply-To: <cf1af6a80a8e2fc4016cf67ab52300c9e7ed3f7d.1584677993.git.viresh.kumar@linaro.org>
References: <cover.1584677993.git.viresh.kumar@linaro.org>
 <cf1af6a80a8e2fc4016cf67ab52300c9e7ed3f7d.1584677993.git.viresh.kumar@linaro.org>
Message-ID: <20200320160409.GA2615@haruka.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

* Got rid of the unused variable warnings

* Changed it to allocate only one bad address and used that pointer for
  all cases

-- 
Cyril Hrubis
chrubis@suse.cz
