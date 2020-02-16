From: Li Wang <liwang@redhat.com>
Date: Sun, 16 Feb 2020 17:09:53 +0800
Subject: [LTP] [PATCH 1/7] lapi/fsmount: Add definitions for fsmount
 related syscalls
In-Reply-To: <98f8a5780f679b90f53fdded8b1b8821d7eb1ce9.1581680021.git.viresh.kumar@linaro.org>
References: <cover.1581680021.git.viresh.kumar@linaro.org>
 <98f8a5780f679b90f53fdded8b1b8821d7eb1ce9.1581680021.git.viresh.kumar@linaro.org>
Message-ID: <CAEemH2eju4-Gv8P_H8teuo3qDYbFmfKL6EZbWQfw6xLHqWa5Xg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh,

Thank you for creating new tests for LTP.

Unfortunately, this 1/7 patch has overlap with zlang@'s patch[1]. It
probably can not be merged if the patch[1] applies first. But the remaining
part is valuable to LTP, you can drop some of this and rebase your code to
make use of the header file again.

[1] http://lists.linux.it/pipermail/ltp/2020-February/015336.html

[CC zlang, pvorel] to have a look at this.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200216/e4dfdd77/attachment-0001.htm>
