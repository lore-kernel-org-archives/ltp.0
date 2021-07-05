From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Mon, 5 Jul 2021 12:03:33 +0200
Subject: [LTP] [PATCH v3 3/3] syscalls/shmget*: Convert into new api
In-Reply-To: <YNnlIVB9M4/11JmT@yuki>
References: <YNM4rlDJLzb4xk6v@yuki>
 <1624512827-3256-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1624512827-3256-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <YNnlIVB9M4/11JmT@yuki>
Message-ID: <98a17ec4-3697-d5ba-583b-ce539782f18c@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 28/06/2021 17:05, Cyril Hrubis wrote:
> Hi!
> Pushed with a minor changes, thanks.
> 

It looks like this commit not only converted into new API but also
changed the test. We started noticing shmget02 and shmget03 test
failures on several systems.

https://bugs.launchpad.net/ubuntu-kernel-tests/+bug/1934432

Reverting the commit helps and tests pass.

Since it is one big patch doing multiple things at the same time, it is
difficult to bisect it more and find the cause.  Any ideas what went
different here comparing to previous version of these tests?


Best regards,
Krzysztof
