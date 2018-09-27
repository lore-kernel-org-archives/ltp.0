From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Thu, 27 Sep 2018 19:12:20 -0300
Subject: [LTP] [PATCH] syscalls/membarrier: Add membarrier() initial test
In-Reply-To: <20180927220941.19783-1-rafael.tinoco@linaro.org>
References: <20180927220941.19783-1-rafael.tinoco@linaro.org>
Message-ID: <CABdQkv8ngR0z+UzgWuFxMG-AThGaeA2B-Vqx=t562hc5Kd25JA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Sep 27, 2018 at 7:09 PM Rafael David Tinoco <
rafael.tinoco@linaro.org> wrote:

> Fixes: #265
>
> Initial test for membarrier() syscall. It tests all existing membarrier
> "commands" (or features), including the need (or not) for previous
> registration for the call to work.
>
> Some features did not exist in older kernels and that is covered by
> skipping some calls, flagging test as skipped & okay, and forcing
> others, making sure that return codes and errno are set right in those
> cases.
>
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
> ---
>

membarrier01 test output for 2 iterations on different kernel versions,
considering behavior is changed depending on membarrier(2) feature
supportability.

#### 4.4

membarrier01.c:302: PASS: membarrier(2): cmd_fail failed as expected
membarrier01.c:302: PASS: membarrier(2): cmd_flags_fail failed as expected
membarrier01.c:296: PASS: membarrier(2): cmd_global_success passed
membarrier01.c:284: PASS: membarrier(2): cmd_private_expedited_fail skipped
(unsupported)
membarrier01.c:321: PASS: membarrier(2):
cmd_private_expedited_register_success failed as expected (unsupported)
membarrier01.c:321: PASS: membarrier(2): cmd_private_expedited_success
failed as expected (unsupported)
membarrier01.c:284: PASS: membarrier(2):
cmd_private_expedited_sync_core_fail skipped (unsupported)
membarrier01.c:321: PASS: membarrier(2):
cmd_private_expedited_sync_core_register_success failed as expected
(unsupported)
membarrier01.c:321: PASS: membarrier(2):
cmd_private_expedited_sync_core_success failed as expected (unsupported)
membarrier01.c:284: PASS: membarrier(2): cmd_global_expedited_success
skipped (unsupported)
membarrier01.c:321: PASS: membarrier(2):
cmd_global_expedited_register_success failed as expected (unsupported)
membarrier01.c:321: PASS: membarrier(2): cmd_global_expedited_success
failed as expected (unsupported)

Summary:
passed   12
failed   0
skipped  0
warnings 0

membarrier01.c:302: PASS: membarrier(2): cmd_fail failed as expected
membarrier01.c:302: PASS: membarrier(2): cmd_flags_fail failed as expected
membarrier01.c:296: PASS: membarrier(2): cmd_global_success passed
membarrier01.c:284: PASS: membarrier(2): cmd_private_expedited_fail skipped
(unsupported)
membarrier01.c:321: PASS: membarrier(2):
cmd_private_expedited_register_success failed as expected (unsupported)
membarrier01.c:321: PASS: membarrier(2): cmd_private_expedited_success
failed as expected (unsupported)
membarrier01.c:284: PASS: membarrier(2):
cmd_private_expedited_sync_core_fail skipped (unsupported)
membarrier01.c:321: PASS: membarrier(2):
cmd_private_expedited_sync_core_register_success failed as expected
(unsupported)
membarrier01.c:321: PASS: membarrier(2):
cmd_private_expedited_sync_core_success failed as expected (unsupported)
membarrier01.c:284: PASS: membarrier(2): cmd_global_expedited_success
skipped (unsupported)
membarrier01.c:321: PASS: membarrier(2):
cmd_global_expedited_register_success failed as expected (unsupported)
membarrier01.c:321: PASS: membarrier(2): cmd_global_expedited_success
failed as expected (unsupported)

Summary:
passed   12
failed   0
skipped  0
warnings 0

#### 4.9

membarrier01.c:302: PASS: membarrier(2): cmd_fail failed as expected
membarrier01.c:302: PASS: membarrier(2): cmd_flags_fail failed as expected
membarrier01.c:296: PASS: membarrier(2): cmd_global_success passed
membarrier01.c:284: PASS: membarrier(2): cmd_private_expedited_fail skipped
(unsupported)
membarrier01.c:321: PASS: membarrier(2):
cmd_private_expedited_register_success failed as expected (unsupported)
membarrier01.c:321: PASS: membarrier(2): cmd_private_expedited_success
failed as expected (unsupported)
membarrier01.c:284: PASS: membarrier(2):
cmd_private_expedited_sync_core_fail skipped (unsupported)
membarrier01.c:321: PASS: membarrier(2):
cmd_private_expedited_sync_core_register_success failed as expected
(unsupported)
membarrier01.c:321: PASS: membarrier(2):
cmd_private_expedited_sync_core_success failed as expected (unsupported)
membarrier01.c:284: PASS: membarrier(2): cmd_global_expedited_success
skipped (unsupported)
membarrier01.c:321: PASS: membarrier(2):
cmd_global_expedited_register_success failed as expected (unsupported)
membarrier01.c:321: PASS: membarrier(2): cmd_global_expedited_success
failed as expected (unsupported)

Summary:
passed   12
failed   0
skipped  0
warnings 0

membarrier01.c:302: PASS: membarrier(2): cmd_fail failed as expected
membarrier01.c:302: PASS: membarrier(2): cmd_flags_fail failed as expected
membarrier01.c:296: PASS: membarrier(2): cmd_global_success passed
membarrier01.c:284: PASS: membarrier(2): cmd_private_expedited_fail skipped
(unsupported)
membarrier01.c:321: PASS: membarrier(2):
cmd_private_expedited_register_success failed as expected (unsupported)
membarrier01.c:321: PASS: membarrier(2): cmd_private_expedited_success
failed as expected (unsupported)
membarrier01.c:284: PASS: membarrier(2):
cmd_private_expedited_sync_core_fail skipped (unsupported)
membarrier01.c:321: PASS: membarrier(2):
cmd_private_expedited_sync_core_register_success failed as expected
(unsupported)
membarrier01.c:321: PASS: membarrier(2):
cmd_private_expedited_sync_core_success failed as expected (unsupported)
membarrier01.c:284: PASS: membarrier(2): cmd_global_expedited_success
skipped (unsupported)
membarrier01.c:321: PASS: membarrier(2):
cmd_global_expedited_register_success failed as expected (unsupported)
membarrier01.c:321: PASS: membarrier(2): cmd_global_expedited_success
failed as expected (unsupported)

Summary:
passed   12
failed   0
skipped  0
warnings 0

#### 4.14

membarrier01.c:302: PASS: membarrier(2): cmd_fail failed as expected
membarrier01.c:302: PASS: membarrier(2): cmd_flags_fail failed as expected
membarrier01.c:296: PASS: membarrier(2): cmd_global_success passed
membarrier01.c:302: PASS: membarrier(2): cmd_private_expedited_fail failed
as expected
membarrier01.c:296: PASS: membarrier(2):
cmd_private_expedited_register_success passed
membarrier01.c:296: PASS: membarrier(2): cmd_private_expedited_success
passed
membarrier01.c:284: PASS: membarrier(2):
cmd_private_expedited_sync_core_fail skipped (unsupported)
membarrier01.c:321: PASS: membarrier(2):
cmd_private_expedited_sync_core_register_success failed as expected
(unsupported)
membarrier01.c:321: PASS: membarrier(2):
cmd_private_expedited_sync_core_success failed as expected (unsupported)
membarrier01.c:284: PASS: membarrier(2): cmd_global_expedited_success
skipped (unsupported)
membarrier01.c:321: PASS: membarrier(2):
cmd_global_expedited_register_success failed as expected (unsupported)
membarrier01.c:321: PASS: membarrier(2): cmd_global_expedited_success
failed as expected (unsupported)

Summary:
passed   12
failed   0
skipped  0
warnings 0

membarrier01.c:302: PASS: membarrier(2): cmd_fail failed as expected
membarrier01.c:302: PASS: membarrier(2): cmd_flags_fail failed as expected
membarrier01.c:296: PASS: membarrier(2): cmd_global_success passed
membarrier01.c:302: PASS: membarrier(2): cmd_private_expedited_fail failed
as expected
membarrier01.c:296: PASS: membarrier(2):
cmd_private_expedited_register_success passed
membarrier01.c:296: PASS: membarrier(2): cmd_private_expedited_success
passed
membarrier01.c:284: PASS: membarrier(2):
cmd_private_expedited_sync_core_fail skipped (unsupported)
membarrier01.c:321: PASS: membarrier(2):
cmd_private_expedited_sync_core_register_success failed as expected
(unsupported)
membarrier01.c:321: PASS: membarrier(2):
cmd_private_expedited_sync_core_success failed as expected (unsupported)
membarrier01.c:284: PASS: membarrier(2): cmd_global_expedited_success
skipped (unsupported)
membarrier01.c:321: PASS: membarrier(2):
cmd_global_expedited_register_success failed as expected (unsupported)
membarrier01.c:321: PASS: membarrier(2): cmd_global_expedited_success
failed as expected (unsupported)

Summary:
passed   12
failed   0
skipped  0
warnings 0

#### 4.16

membarrier01.c:302: PASS: membarrier(2): cmd_fail failed as expected
membarrier01.c:302: PASS: membarrier(2): cmd_flags_fail failed as expected
membarrier01.c:296: PASS: membarrier(2): cmd_global_success passed
membarrier01.c:302: PASS: membarrier(2): cmd_private_expedited_fail failed
as expected
membarrier01.c:296: PASS: membarrier(2):
cmd_private_expedited_register_success passed
membarrier01.c:296: PASS: membarrier(2): cmd_private_expedited_success
passed
membarrier01.c:302: PASS: membarrier(2):
cmd_private_expedited_sync_core_fail failed as expected
membarrier01.c:296: PASS: membarrier(2):
cmd_private_expedited_sync_core_register_success passed
membarrier01.c:296: PASS: membarrier(2):
cmd_private_expedited_sync_core_success passed
membarrier01.c:296: PASS: membarrier(2): cmd_global_expedited_success passed
membarrier01.c:296: PASS: membarrier(2):
cmd_global_expedited_register_success passed
membarrier01.c:296: PASS: membarrier(2): cmd_global_expedited_success passed

Summary:
passed   12
failed   0
skipped  0
warnings 0

membarrier01.c:302: PASS: membarrier(2): cmd_fail failed as expected
membarrier01.c:302: PASS: membarrier(2): cmd_flags_fail failed as expected
membarrier01.c:296: PASS: membarrier(2): cmd_global_success passed
membarrier01.c:302: PASS: membarrier(2): cmd_private_expedited_fail failed
as expected
membarrier01.c:296: PASS: membarrier(2):
cmd_private_expedited_register_success passed
membarrier01.c:296: PASS: membarrier(2): cmd_private_expedited_success
passed
membarrier01.c:302: PASS: membarrier(2):
cmd_private_expedited_sync_core_fail failed as expected
membarrier01.c:296: PASS: membarrier(2):
cmd_private_expedited_sync_core_register_success passed
membarrier01.c:296: PASS: membarrier(2):
cmd_private_expedited_sync_core_success passed
membarrier01.c:296: PASS: membarrier(2): cmd_global_expedited_success passed
membarrier01.c:296: PASS: membarrier(2):
cmd_global_expedited_register_success passed
membarrier01.c:296: PASS: membarrier(2): cmd_global_expedited_success passed

Summary:
passed   12
failed   0
skipped  0
warnings 0

#### 4.17

membarrier01.c:302: PASS: membarrier(2): cmd_fail failed as expected
membarrier01.c:302: PASS: membarrier(2): cmd_flags_fail failed as expected
membarrier01.c:296: PASS: membarrier(2): cmd_global_success passed
membarrier01.c:302: PASS: membarrier(2): cmd_private_expedited_fail failed
as expected
membarrier01.c:296: PASS: membarrier(2):
cmd_private_expedited_register_success passed
membarrier01.c:296: PASS: membarrier(2): cmd_private_expedited_success
passed
membarrier01.c:302: PASS: membarrier(2):
cmd_private_expedited_sync_core_fail failed as expected
membarrier01.c:296: PASS: membarrier(2):
cmd_private_expedited_sync_core_register_success passed
membarrier01.c:296: PASS: membarrier(2):
cmd_private_expedited_sync_core_success passed
membarrier01.c:296: PASS: membarrier(2): cmd_global_expedited_success passed
membarrier01.c:296: PASS: membarrier(2):
cmd_global_expedited_register_success passed
membarrier01.c:296: PASS: membarrier(2): cmd_global_expedited_success passed

Summary:
passed   12
failed   0
skipped  0
warnings 0

membarrier01.c:302: PASS: membarrier(2): cmd_fail failed as expected
membarrier01.c:302: PASS: membarrier(2): cmd_flags_fail failed as expected
membarrier01.c:296: PASS: membarrier(2): cmd_global_success passed
membarrier01.c:302: PASS: membarrier(2): cmd_private_expedited_fail failed
as expected
membarrier01.c:296: PASS: membarrier(2):
cmd_private_expedited_register_success passed
membarrier01.c:296: PASS: membarrier(2): cmd_private_expedited_success
passed
membarrier01.c:302: PASS: membarrier(2):
cmd_private_expedited_sync_core_fail failed as expected
membarrier01.c:296: PASS: membarrier(2):
cmd_private_expedited_sync_core_register_success passed
membarrier01.c:296: PASS: membarrier(2):
cmd_private_expedited_sync_core_success passed
membarrier01.c:296: PASS: membarrier(2): cmd_global_expedited_success passed
membarrier01.c:296: PASS: membarrier(2):
cmd_global_expedited_register_success passed
membarrier01.c:296: PASS: membarrier(2): cmd_global_expedited_success passed

Summary:
passed   12
failed   0
skipped  0
warnings 0

#### 4.18

membarrier01.c:302: PASS: membarrier(2): cmd_fail failed as expected
membarrier01.c:302: PASS: membarrier(2): cmd_flags_fail failed as expected
membarrier01.c:296: PASS: membarrier(2): cmd_global_success passed
membarrier01.c:302: PASS: membarrier(2): cmd_private_expedited_fail failed
as expected
membarrier01.c:296: PASS: membarrier(2):
cmd_private_expedited_register_success passed
membarrier01.c:296: PASS: membarrier(2): cmd_private_expedited_success
passed
membarrier01.c:302: PASS: membarrier(2):
cmd_private_expedited_sync_core_fail failed as expected
membarrier01.c:296: PASS: membarrier(2):
cmd_private_expedited_sync_core_register_success passed
membarrier01.c:296: PASS: membarrier(2):
cmd_private_expedited_sync_core_success passed
membarrier01.c:296: PASS: membarrier(2): cmd_global_expedited_success passed
membarrier01.c:296: PASS: membarrier(2):
cmd_global_expedited_register_success passed
membarrier01.c:296: PASS: membarrier(2): cmd_global_expedited_success passed

Summary:
passed   12
failed   0
skipped  0
warnings 0

membarrier01.c:302: PASS: membarrier(2): cmd_fail failed as expected
membarrier01.c:302: PASS: membarrier(2): cmd_flags_fail failed as expected
membarrier01.c:296: PASS: membarrier(2): cmd_global_success passed
membarrier01.c:302: PASS: membarrier(2): cmd_private_expedited_fail failed
as expected
membarrier01.c:296: PASS: membarrier(2):
cmd_private_expedited_register_success passed
membarrier01.c:296: PASS: membarrier(2): cmd_private_expedited_success
passed
membarrier01.c:302: PASS: membarrier(2):
cmd_private_expedited_sync_core_fail failed as expected
membarrier01.c:296: PASS: membarrier(2):
cmd_private_expedited_sync_core_register_success passed
membarrier01.c:296: PASS: membarrier(2):
cmd_private_expedited_sync_core_success passed
membarrier01.c:296: PASS: membarrier(2): cmd_global_expedited_success passed
membarrier01.c:296: PASS: membarrier(2):
cmd_global_expedited_register_success passed
membarrier01.c:296: PASS: membarrier(2): cmd_global_expedited_success passed

Summary:
passed   12
failed   0
skipped  0
warnings 0
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180927/2858cd9d/attachment-0001.html>
