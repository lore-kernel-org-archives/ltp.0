From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 25 Jul 2019 14:02:42 +0300
Subject: [LTP] [PATCH v6 3/3] syscalls/copy_file_range02: increase
 coverage and remove EXDEV test
In-Reply-To: <5D3980E6.8010104@cn.fujitsu.com>
References: <5D30200B.4050306@cn.fujitsu.com>
 <1564030915-3211-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1564030915-3211-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAOQ4uxg-5UUTB6Z=4Ma9+6LkLVnCz6NBFS4=7Zq_pJfNhZFRqA@mail.gmail.com>
 <5D3941C4.2070601@cn.fujitsu.com>
 <CAOQ4uxg7w51AVD6fig9HH0s7vjC=G2fz8H1nauBZ3V5TiRzuVQ@mail.gmail.com>
 <5D3980E6.8010104@cn.fujitsu.com>
Message-ID: <CAOQ4uxgAwSZEjfE=4PBW6OC2Hy95drErBEGx6r7tsv_gLSve-Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> > Right, sorry, missed that.
> > It is generally better not to define 1024 array on the stack.
> > Most LTP tests define test path vars as static char arrays in top of test file.
> Hi Amir
>
>   I think it is a code-style preference. IMO, 1024 array is not enough large and this function is not
> interate or recursion call.  It don't make stack overflow. Also, this test path is only used in setup().
>   So, I think keeping it is no problem.
>

Totally agree. It's a matter of coding style so up to project maintainer to
enforce it. I don't mind. Personally, I just prefer to use the code style of
the project I am contributing to.

Thanks,
Amir.
