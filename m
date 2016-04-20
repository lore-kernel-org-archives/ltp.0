From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 20 Apr 2016 15:10:51 +0800
Subject: [LTP] Question about patch "jbd2: Fix oops in
	jbd2_journal_remove_journal_head()"
Message-ID: <57172B7B.2020503@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

hello,

For this patch:
-------------------------------------------------------------------
jbd2: Fix oops in jbd2_journal_remove_journal_head()

jbd2_journal_remove_journal_head() can oops when trying to access
journal_head returned by bh2jh(). This is caused for example by the
following race:

	TASK1					TASK2
  jbd2_journal_commit_transaction()
    ...
    processing t_forget list
      __jbd2_journal_refile_buffer(jh);
      if (!jh->b_transaction) {
        jbd_unlock_bh_state(bh);
					jbd2_journal_try_to_free_buffers()
					  jbd2_journal_grab_journal_head(bh)
					  jbd_lock_bh_state(bh)
					  __journal_try_to_free_buffer()
					  jbd2_journal_put_journal_head(jh)
        jbd2_journal_remove_journal_head(bh);

jbd2_journal_put_journal_head() in TASK2 sees that b_jcount == 0 and
buffer is not part of any transaction and thus frees journal_head
before TASK1 gets to doing so. Note that even buffer_head can be
released by try_to_free_buffers() after
jbd2_journal_put_journal_head() which adds even larger opportunity for
oops (but I didn't see this happen in reality).

Fix the problem by making transactions hold their own journal_head
reference (in b_jcount). That way we don't have to remove journal_head
explicitely via jbd2_journal_remove_journal_head() and instead just
remove journal_head when b_jcount drops to zero. The result of this is
that [__]jbd2_journal_refile_buffer(),
[__]jbd2_journal_unfile_buffer(), and
__jdb2_journal_remove_checkpoint() can free journal_head which needs
modification of a few callers. Also we have to be careful because once
journal_head is removed, buffer_head might be freed as well. So we
have to get our own buffer_head reference where it matters.

-------------------------------------------------------------------
This patch maybe somewhat old... Currently we're trying to write regrsesion
test for this patch, do you still remember any steps to reproduce this bug?
Thank you very much.

Regards,
Xiao Yang



