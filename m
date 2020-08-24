From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 24 Aug 2020 15:46:30 +0530
Subject: [LTP] BUG: Bad page state in process true  pfn:a8fed on arm
In-Reply-To: <CA+G9fYt=oYWHEG6VNkfEh8+UxbReS6_+9hnz+1bOYZHj5j1F_Q@mail.gmail.com>
References: <CA+G9fYt=oYWHEG6VNkfEh8+UxbReS6_+9hnz+1bOYZHj5j1F_Q@mail.gmail.com>
Message-ID: <CA+G9fYtVCb6p_eeBayp_bzJGYFBOx+yG+Bgpda3KcFy-Yj1VgA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, 24 Aug 2020 at 15:14, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Kernel BUG noticed on arm architecture on linux next 20200824 tag kernel
> while running LTP CVE "thp01 -I 120" , LTP mm, LTP hugetlb test cases
> and libhugetlbfs test suite.

BAD: next-20200820
GOOD: next-20200819

We are trying to bisect this problem and get back to you shortly.

- Naresh
