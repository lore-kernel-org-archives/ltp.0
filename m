From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Fri, 5 Oct 2018 17:46:12 -0300
Subject: [LTP] [PATCH v2] syscalls/membarrier: Add membarrier() initial
 test
In-Reply-To: <20181005203910.23360-1-rafael.tinoco@linaro.org>
References: <243767154.55279006.1538383679362.JavaMail.zimbra@redhat.com>
 <20181005203910.23360-1-rafael.tinoco@linaro.org>
Message-ID: <d6019a12-ff70-e809-709c-fcab7f870267@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10/5/18 5:39 PM, Rafael David Tinoco wrote:
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
> Tests are done in a child process due to inexistent kernel interface to
> "unregister" the process from being affected by membarrier() call.
> 
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
> ---

Jan,

Hopefully I have addressed all your review points in this version, 
please let me know if not, I'll be happy to make a new version if needed.

I have added a corner case for a return code that has changed after 
4.16, and I'm running the tests now in a child process (so I needed to 
create a pre-req registration flag). All this together with what you 
have asked for, I believe.

Please find bellow the tests done for this v2:

## 4.4

membarrier01.c:313: PASS: membarrier(2): cmd_fail failed as expected
membarrier01.c:313: PASS: membarrier(2): cmd_flags_fail failed as expected
membarrier01.c:309: PASS: membarrier(2): cmd_global_success passed
membarrier01.c:287: PASS: membarrier(2): cmd_private_expedited_fail 
skipped (unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_private_expedited_register_success failed as expected (unsupported)
membarrier01.c:328: PASS: membarrier(2): cmd_private_expedited_success 
failed as expected (unsupported)
membarrier01.c:287: PASS: membarrier(2): 
cmd_private_expedited_sync_core_fail skipped (unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_private_expedited_sync_core_register_success failed as expected 
(unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_private_expedited_sync_core_success failed as expected (unsupported)
membarrier01.c:287: PASS: membarrier(2): cmd_global_expedited_success 
skipped (unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_global_expedited_register_success failed as expected (unsupported)
membarrier01.c:328: PASS: membarrier(2): cmd_global_expedited_success 
failed as expected (unsupported)

Summary:
passed   12
failed   0
skipped  0
warnings 0

membarrier01.c:313: PASS: membarrier(2): cmd_fail failed as expected
membarrier01.c:313: PASS: membarrier(2): cmd_flags_fail failed as expected
membarrier01.c:309: PASS: membarrier(2): cmd_global_success passed
membarrier01.c:287: PASS: membarrier(2): cmd_private_expedited_fail 
skipped (unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_private_expedited_register_success failed as expected (unsupported)
membarrier01.c:328: PASS: membarrier(2): cmd_private_expedited_success 
failed as expected (unsupported)
membarrier01.c:287: PASS: membarrier(2): 
cmd_private_expedited_sync_core_fail skipped (unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_private_expedited_sync_core_register_success failed as expected 
(unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_private_expedited_sync_core_success failed as expected (unsupported)
membarrier01.c:287: PASS: membarrier(2): cmd_global_expedited_success 
skipped (unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_global_expedited_register_success failed as expected (unsupported)
membarrier01.c:328: PASS: membarrier(2): cmd_global_expedited_success 
failed as expected (unsupported)

Summary:
passed   12
failed   0
skipped  0
warnings 0

## 4.9

membarrier01.c:313: PASS: membarrier(2): cmd_fail failed as expected
membarrier01.c:313: PASS: membarrier(2): cmd_flags_fail failed as expected
membarrier01.c:309: PASS: membarrier(2): cmd_global_success passed
membarrier01.c:287: PASS: membarrier(2): cmd_private_expedited_fail 
skipped (unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_private_expedited_register_success failed as expected (unsupported)
membarrier01.c:328: PASS: membarrier(2): cmd_private_expedited_success 
failed as expected (unsupported)
membarrier01.c:287: PASS: membarrier(2): 
cmd_private_expedited_sync_core_fail skipped (unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_private_expedited_sync_core_register_success failed as expected 
(unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_private_expedited_sync_core_success failed as expected (unsupported)
membarrier01.c:287: PASS: membarrier(2): cmd_global_expedited_success 
skipped (unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_global_expedited_register_success failed as expected (unsupported)
membarrier01.c:328: PASS: membarrier(2): cmd_global_expedited_success 
failed as expected (unsupported)

Summary:
passed   12
failed   0
skipped  0
warnings 0

membarrier01.c:313: PASS: membarrier(2): cmd_fail failed as expected
membarrier01.c:313: PASS: membarrier(2): cmd_flags_fail failed as expected
membarrier01.c:309: PASS: membarrier(2): cmd_global_success passed
membarrier01.c:287: PASS: membarrier(2): cmd_private_expedited_fail 
skipped (unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_private_expedited_register_success failed as expected (unsupported)
membarrier01.c:328: PASS: membarrier(2): cmd_private_expedited_success 
failed as expected (unsupported)
membarrier01.c:287: PASS: membarrier(2): 
cmd_private_expedited_sync_core_fail skipped (unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_private_expedited_sync_core_register_success failed as expected 
(unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_private_expedited_sync_core_success failed as expected (unsupported)
membarrier01.c:287: PASS: membarrier(2): cmd_global_expedited_success 
skipped (unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_global_expedited_register_success failed as expected (unsupported)
membarrier01.c:328: PASS: membarrier(2): cmd_global_expedited_success 
failed as expected (unsupported)

Summary:
passed   12
failed   0
skipped  0
warnings 0

## 4.14

membarrier01.c:313: PASS: membarrier(2): cmd_fail failed as expected
membarrier01.c:313: PASS: membarrier(2): cmd_flags_fail failed as expected
membarrier01.c:309: PASS: membarrier(2): cmd_global_success passed
membarrier01.c:287: PASS: membarrier(2): cmd_private_expedited_fail 
skipped (unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_private_expedited_register_success failed as expected (unsupported)
membarrier01.c:328: PASS: membarrier(2): cmd_private_expedited_success 
failed as expected (unsupported)
membarrier01.c:287: PASS: membarrier(2): 
cmd_private_expedited_sync_core_fail skipped (unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_private_expedited_sync_core_register_success failed as expected 
(unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_private_expedited_sync_core_success failed as expected (unsupported)
membarrier01.c:287: PASS: membarrier(2): cmd_global_expedited_success 
skipped (unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_global_expedited_register_success failed as expected (unsupported)
membarrier01.c:328: PASS: membarrier(2): cmd_global_expedited_success 
failed as expected (unsupported)

Summary:
passed   12
failed   0
skipped  0
warnings 0

membarrier01.c:313: PASS: membarrier(2): cmd_fail failed as expected
membarrier01.c:313: PASS: membarrier(2): cmd_flags_fail failed as expected
membarrier01.c:309: PASS: membarrier(2): cmd_global_success passed
membarrier01.c:287: PASS: membarrier(2): cmd_private_expedited_fail 
skipped (unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_private_expedited_register_success failed as expected (unsupported)
membarrier01.c:328: PASS: membarrier(2): cmd_private_expedited_success 
failed as expected (unsupported)
membarrier01.c:287: PASS: membarrier(2): 
cmd_private_expedited_sync_core_fail skipped (unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_private_expedited_sync_core_register_success failed as expected 
(unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_private_expedited_sync_core_success failed as expected (unsupported)
membarrier01.c:287: PASS: membarrier(2): cmd_global_expedited_success 
skipped (unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_global_expedited_register_success failed as expected (unsupported)
membarrier01.c:328: PASS: membarrier(2): cmd_global_expedited_success 
failed as expected (unsupported)

Summary:
passed   12
failed   0
skipped  0
warnings 0

## 4.16

membarrier01.c:313: PASS: membarrier(2): cmd_fail failed as expected
membarrier01.c:313: PASS: membarrier(2): cmd_flags_fail failed as expected
membarrier01.c:309: PASS: membarrier(2): cmd_global_success passed
membarrier01.c:287: PASS: membarrier(2): cmd_private_expedited_fail 
skipped (unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_private_expedited_register_success failed as expected (unsupported)
membarrier01.c:328: PASS: membarrier(2): cmd_private_expedited_success 
failed as expected (unsupported)
membarrier01.c:287: PASS: membarrier(2): 
cmd_private_expedited_sync_core_fail skipped (unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_private_expedited_sync_core_register_success failed as expected 
(unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_private_expedited_sync_core_success failed as expected (unsupported)
membarrier01.c:287: PASS: membarrier(2): cmd_global_expedited_success 
skipped (unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_global_expedited_register_success failed as expected (unsupported)
membarrier01.c:328: PASS: membarrier(2): cmd_global_expedited_success 
failed as expected (unsupported)

Summary:
passed   12
failed   0
skipped  0
warnings 0

membarrier01.c:313: PASS: membarrier(2): cmd_fail failed as expected
membarrier01.c:313: PASS: membarrier(2): cmd_flags_fail failed as expected
membarrier01.c:309: PASS: membarrier(2): cmd_global_success passed
membarrier01.c:287: PASS: membarrier(2): cmd_private_expedited_fail 
skipped (unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_private_expedited_register_success failed as expected (unsupported)
membarrier01.c:328: PASS: membarrier(2): cmd_private_expedited_success 
failed as expected (unsupported)
membarrier01.c:287: PASS: membarrier(2): 
cmd_private_expedited_sync_core_fail skipped (unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_private_expedited_sync_core_register_success failed as expected 
(unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_private_expedited_sync_core_success failed as expected (unsupported)
membarrier01.c:287: PASS: membarrier(2): cmd_global_expedited_success 
skipped (unsupported)
membarrier01.c:328: PASS: membarrier(2): 
cmd_global_expedited_register_success failed as expected (unsupported)
membarrier01.c:328: PASS: membarrier(2): cmd_global_expedited_success 
failed as expected (unsupported)

Summary:
passed   12
failed   0
skipped  0
warnings 0

## 4.18

membarrier01.c:313: PASS: membarrier(2): cmd_fail failed as expected
membarrier01.c:313: PASS: membarrier(2): cmd_flags_fail failed as expected
membarrier01.c:309: PASS: membarrier(2): cmd_global_success passed
membarrier01.c:313: PASS: membarrier(2): cmd_private_expedited_fail 
failed as expected
membarrier01.c:340: PASS: membarrier(2): 
cmd_private_expedited_register_success passed
membarrier01.c:340: PASS: membarrier(2): cmd_private_expedited_success 
passed
membarrier01.c:313: PASS: membarrier(2): 
cmd_private_expedited_sync_core_fail failed as expected
membarrier01.c:340: PASS: membarrier(2): 
cmd_private_expedited_sync_core_register_success passed
membarrier01.c:340: PASS: membarrier(2): 
cmd_private_expedited_sync_core_success passed
membarrier01.c:309: PASS: membarrier(2): cmd_global_expedited_success passed
membarrier01.c:340: PASS: membarrier(2): 
cmd_global_expedited_register_success passed
membarrier01.c:340: PASS: membarrier(2): cmd_global_expedited_success passed

Summary:
passed   12
failed   0
skipped  0
warnings 0

membarrier01.c:313: PASS: membarrier(2): cmd_fail failed as expected
membarrier01.c:313: PASS: membarrier(2): cmd_flags_fail failed as expected
membarrier01.c:309: PASS: membarrier(2): cmd_global_success passed
membarrier01.c:313: PASS: membarrier(2): cmd_private_expedited_fail 
failed as expected
membarrier01.c:340: PASS: membarrier(2): 
cmd_private_expedited_register_success passed
membarrier01.c:340: PASS: membarrier(2): cmd_private_expedited_success 
passed
membarrier01.c:313: PASS: membarrier(2): 
cmd_private_expedited_sync_core_fail failed as expected
membarrier01.c:340: PASS: membarrier(2): 
cmd_private_expedited_sync_core_register_success passed
membarrier01.c:340: PASS: membarrier(2): 
cmd_private_expedited_sync_core_success passed
membarrier01.c:309: PASS: membarrier(2): cmd_global_expedited_success passed
membarrier01.c:340: PASS: membarrier(2): 
cmd_global_expedited_register_success passed
membarrier01.c:340: PASS: membarrier(2): cmd_global_expedited_success passed

Summary:
passed   12
failed   0
skipped  0
warnings 0


-- 
Rafael D. Tinoco
