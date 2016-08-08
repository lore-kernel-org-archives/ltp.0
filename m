From: Li Wang <wangli.ahau@gmail.com>
Date: Mon, 8 Aug 2016 16:44:24 +0800
Subject: [LTP] [PATCH] syscalls/signal06: fix test for regression with
 earlier version of gcc and kernel
In-Reply-To: <1470380281-20334-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1470380281-20334-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <CAE1O6mgTj1WsRg1-UHpq32onixeKpo3xTbU6FiqDTK=jdE=uRw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 5 August 2016 at 14:58, Guangwen Feng <fenggw-fnst@cn.fujitsu.com> wrote:
> 1. Currently, following code is incorrect on some releases with
>    earlier version of gcc(tested on RHEL5.11GA):
>
>         while (D == d && loop < LOOPS) {
>
>    Because the argument in function test(double d) is used via (%rsp),
>    but here we actually need a xmm register to trigger the fpu bug.
>    So use global value instead to make sure to take use of xmm.

Sounds reasonable! To verify that I did disassemble work of the
pre/post signal06 for comparison:

signal06 old version
-------------------------
void test(double d)
{
        int loop = 0;
        int pid = getpid();
  402846:       89 c7                   mov    %eax,%edi

        D = d;
  402848:       f2 0f 11 05 b0 27 21    movsd  %xmm0,0x2127b0(%rip)
    # 615000 <D>
  40284f:       00
        while (D == d && loop < LOOPS) {
  402850:       f2 0f 10 05 a8 27 21    movsd  0x2127a8(%rip),%xmm0
    # 615000 <D>
  402857:       00
  402858:       66 0f 2e 44 24 08       ucomisd 0x8(%rsp),%xmm0
  40285e:       0f 85 b8 00 00 00       jne    40291c <test+0xec>
  402864:       0f 8a b2 00 00 00       jp     40291c <test+0xec>
  40286a:       31 db                   xor    %ebx,%ebx
  40286c:       ba c8 00 00 00          mov    $0xc8,%edx
  402871:       be 01 00 00 00          mov    $0x1,%esi
  402876:       eb 0a                   jmp    402882 <test+0x52>
  402878:       81 fb 10 27 00 00       cmp    $0x2710,%ebx
  40287e:       66 90                   xchg   %ax,%ax
  402880:       74 6d                   je     4028ef <test+0xbf>


after applying this patch
------------------------------
void test(void)
{
        int loop = 0;
  402c58:       bb 00 00 00 00          mov    $0x0,%ebx
        int pid = getpid();

        D = VALUE;
        while (D == VALUE && loop < LOOPS) {
  402c5d:       0f 85 b5 00 00 00       jne    402d18 <test+0xe8>
  402c63:       89 c7                   mov    %eax,%edi
                /* sys_tkill(pid, SIGHUP); asm to avoid save/reload
                 * fp regs around c call */
                asm ("" : : "a"(__NR_tkill), "D"(pid), "S"(SIGHUP));
  402c65:       ba c8 00 00 00          mov    $0xc8,%edx
  402c6a:       be 01 00 00 00          mov    $0x1,%esi
{
        int loop = 0;
        int pid = getpid();

        D = VALUE;
        while (D == VALUE && loop < LOOPS) {
  402c6f:       66 0f 28 d1             movapd %xmm1,%xmm2
  402c73:       eb 11                   jmp    402c86 <test+0x56>
  402c75:       0f 1f 00                nopl   (%rax)
  402c78:       66 0f 2e c2             ucomisd %xmm2,%xmm0
  402c7c:       75 1d                   jne    402c9b <test+0x6b>
  402c7e:       81 fb a0 86 01 00       cmp    $0x186a0,%ebx
  402c84:       74 65                   je     402ceb <test+0xbb>


>
> 2. Although this regression test is designed to trigger SIGSEGV
>    intentionally, on some releases with old kernel(tested on RHEL5.11GA),
>    this will still lead to segmentation fault that terminate the program
>    and break the test even though compiling with -O2.  So slightly adjust
>    the weight of the codes in child thread to depress SIGSEGV trigger's
>    chance while increase LOOPS to ensure reproducible.

This is also acceptable, seems too many signals more than one kenel
can handled that easily cause segmental fault at the moment.

I test this patch on RHEL5.11(reproduced) and RHEL7.2(pass), it works fine.

Regards,
Li Wang
