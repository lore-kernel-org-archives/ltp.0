Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED84C48BF6
	for <ltp@archiver.kernel.org>; Mon, 26 Feb 2024 09:31:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 052ED3CEF96
	for <ltp@archiver.kernel.org>; Mon, 26 Feb 2024 10:31:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52BD53CAB65
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 10:30:51 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=vbabka@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 72E8B207A0B
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 10:30:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2EC4C2250B
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 09:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708939847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4xnel4PnjKBhLbT6KkJuLXOXKs6ed5f1Zz3fl1n1apc=;
 b=0EGhSKpHP4OdpOkx7EX/czdlkbAoxzaa/J9EOc4iXPnTqIKdaGM8emX0+rwcrND+NtVvfM
 7MXGntsPwoA4iklmNIl8DOzfDNVLH8KatT8NvHdreVEpr8exxhwC1zCJ8KtuHJi+GYQp4P
 0FKspATTj7sQOlL3O/LcirijA3yuVzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708939847;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4xnel4PnjKBhLbT6KkJuLXOXKs6ed5f1Zz3fl1n1apc=;
 b=yFqj1w0tP4nAshJAxWC/n5Sug1dRYHglcMAxVe1vowqg+NNNbu1+eI0qsErM9GfMZDZYh5
 hUEywlEas3/ucGCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708939847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4xnel4PnjKBhLbT6KkJuLXOXKs6ed5f1Zz3fl1n1apc=;
 b=0EGhSKpHP4OdpOkx7EX/czdlkbAoxzaa/J9EOc4iXPnTqIKdaGM8emX0+rwcrND+NtVvfM
 7MXGntsPwoA4iklmNIl8DOzfDNVLH8KatT8NvHdreVEpr8exxhwC1zCJ8KtuHJi+GYQp4P
 0FKspATTj7sQOlL3O/LcirijA3yuVzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708939847;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4xnel4PnjKBhLbT6KkJuLXOXKs6ed5f1Zz3fl1n1apc=;
 b=yFqj1w0tP4nAshJAxWC/n5Sug1dRYHglcMAxVe1vowqg+NNNbu1+eI0qsErM9GfMZDZYh5
 hUEywlEas3/ucGCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 262B013A3A
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 09:30:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BMzhCEda3GXsIQAAD6G6ig
 (envelope-from <vbabka@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 09:30:47 +0000
Message-ID: <b4c096fa-e7dd-49ec-a237-4c81498bb2ac@suse.cz>
Date: Mon, 26 Feb 2024 10:30:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
References: <20240222215930.14637-2-vbabka@suse.cz>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
To: ltp@lists.linux.it
In-Reply-To: <20240222215930.14637-2-vbabka@suse.cz>
X-Forwarded-Message-Id: <20240222215930.14637-2-vbabka@suse.cz>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0EGhSKpH;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yFqj1w0t
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 XM_UA_NO_VERSION(0.01)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_DN_NONE(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,oracle.com:email];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: 2EC4C2250B
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Fwd: [PATCH v2] mm,
 mmap: fix vma_merge() case 7 with vma_ops->close
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi ltp,

I assume you'd like to turn the reproducer (from Michal Hocko) to a LTP test?

Cheers,
Vlastimil

-------- Forwarded Message --------
Subject: [PATCH v2] mm, mmap: fix vma_merge() case 7 with vma_ops->close
Date: Thu, 22 Feb 2024 22:59:31 +0100
From: Vlastimil Babka <vbabka@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Vlastimil Babka
<vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, Liam R . Howlett
<Liam.Howlett@oracle.com>, Lorenzo Stoakes <lstoakes@gmail.com>,
stable@vger.kernel.org

When debugging issues with a workload using SysV shmem, Michal Hocko has
come up with a reproducer that shows how a series of mprotect()
operations can result in an elevated shm_nattch and thus leak of the
resource.

The problem is caused by wrong assumptions in vma_merge() commit
714965ca8252 ("mm/mmap: start distinguishing if vma can be removed in
mergeability test"). The shmem vmas have a vma_ops->close callback
that decrements shm_nattch, and we remove the vma without calling it.

vma_merge() has thus historically avoided merging vma's with
vma_ops->close and commit 714965ca8252 was supposed to keep it that way.
It relaxed the checks for vma_ops->close in can_vma_merge_after()
assuming that it is never called on a vma that would be a candidate for
removal. However, the vma_merge() code does also use the result of this
check in the decision to remove a different vma in the merge case 7.

A robust solution would be to refactor vma_merge() code in a way that
the vma_ops->close check is only done for vma's that are actually going
to be removed, and not as part of the preliminary checks. That would
both solve the existing bug, and also allow additional merges that the
checks currently prevent unnecessarily in some cases.

However to fix the existing bug first with a minimized risk, and for
easier stable backports, this patch only adds a vma_ops->close check to
the buggy case 7 specifically. All other cases of vma removal are
covered by the can_vma_merge_before() check that includes the test for
vma_ops->close.

The reproducer code, adapted from Michal Hocko's code:

int main(int argc, char *argv[]) {
  int segment_id;
  size_t segment_size = 20 * PAGE_SIZE;
  char * sh_mem;
  struct shmid_ds shmid_ds;

  key_t key = 0x1234;
  segment_id = shmget(key, segment_size,
                      IPC_CREAT | IPC_EXCL | S_IRUSR | S_IWUSR);
  sh_mem = (char *)shmat(segment_id, NULL, 0);

  mprotect(sh_mem + 2*PAGE_SIZE, PAGE_SIZE, PROT_NONE);

  mprotect(sh_mem + PAGE_SIZE, PAGE_SIZE, PROT_WRITE);

  mprotect(sh_mem + 2*PAGE_SIZE, PAGE_SIZE, PROT_WRITE);

  shmdt(sh_mem);

  shmctl(segment_id, IPC_STAT, &shmid_ds);
  printf("nattch after shmdt(): %lu (expected: 0)\n", shmid_ds.shm_nattch);

  if (shmctl(segment_id, IPC_RMID, 0))
          printf("IPCRM failed %d\n", errno);
  return (shmid_ds.shm_nattch) ? 1 : 0;
}

Fixes: 714965ca8252 ("mm/mmap: start distinguishing if vma can be removed in
mergeability test")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reported-by: Michal Hocko <mhocko@suse.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: <stable@vger.kernel.org>
---
v2: deduplicate code, per Lorenzo
 mm/mmap.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index d89770eaab6b..3281287771c9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -954,13 +954,21 @@ static struct vm_area_struct
 	} else if (merge_prev) {			/* case 2 */
 		if (curr) {
 			vma_start_write(curr);
-			err = dup_anon_vma(prev, curr, &anon_dup);
 			if (end == curr->vm_end) {	/* case 7 */
+				/*
+				 * can_vma_merge_after() assumed we would not be
+				 * removing prev vma, so it skipped the check
+				 * for vm_ops->close, but we are removing curr
+				 */
+				if (curr->vm_ops && curr->vm_ops->close)
+					err = -EINVAL;
 				remove = curr;
 			} else {			/* case 5 */
 				adjust = curr;
 				adj_start = (end - curr->vm_start);
 			}
+			if (!err)
+				err = dup_anon_vma(prev, curr, &anon_dup);
 		}
 	} else { /* merge_next */
 		vma_start_write(next);
-- 
2.43.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
