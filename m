Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74BDC433FE
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 07:10:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E4033C7A4A
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 08:10:55 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE1523C2A4D
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 08:10:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 923121A00912
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 08:10:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643008241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nna4ax4ROROvVuKfIn/l1D1H+gLbV9mAxcYoIuQg+fE=;
 b=DojxyODImgp3JtXIXFIlC5/oAjUTaAZhZ9wIHJpb1QQ3e3k6KntBifottGNUpijU+LEvf/
 0dKsRP7GrPmaIDJYWEomKVm9VICtK/LFKlj5gxBG1ZiJe4rE/HxWqNeHDD4ZdJ/7sIeqFe
 GY+svkC1tAGdFfmM3O6H7kwYNLotAak=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-85-WpdDMO0xP86CJk86uObX2A-1; Mon, 24 Jan 2022 02:10:27 -0500
X-MC-Unique: WpdDMO0xP86CJk86uObX2A-1
Received: by mail-yb1-f200.google.com with SMTP id
 i10-20020a25540a000000b0061391789216so32117394ybb.2
 for <ltp@lists.linux.it>; Sun, 23 Jan 2022 23:10:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Nna4ax4ROROvVuKfIn/l1D1H+gLbV9mAxcYoIuQg+fE=;
 b=YkVFAR9U1SKt67+c8ZgskyTLhUnwa/MwV6XB4Ywq7lDExbLLaEivJ9eXm1oaDTAqPO
 9wxziYvNzHrML8dOAt9MON86nBE/k52F1K803LBw19Kkiai0/W9z9fesHaIE42iouDv0
 g1RK5oWLwMnjEwF3PtU4L3QdFE1rHol1ki3HEeUOzLUuX0bZx4g9YJcptppb99SmOMQf
 GByXDFKXajKUYy3rxDTMZlAHm9GTQTMIKrA6xOPIat6SCyVMr9yEES+C+icxT4BYWQTn
 2AW6W09h5VNKLXYHxyct6SN1z8nkTl4gH+sWENfpuAekL4XcJCe3858S8SbOvinYBBK1
 g/WQ==
X-Gm-Message-State: AOAM533Ae4ws6Q4RxKiLzb6kmcPQbP0jNVcw5eMfoz4ZTZZuPwBlbGZP
 c4JyJi8TVETtQUHL/tPe6FDx+bHcONVKPzeWyyziwF94JDWvljo+IRa6l5paoWmsxpUpvm/60up
 Bb2lwnRGX/PbARAyJiNfhSjfUTpY=
X-Received: by 2002:a25:d57:: with SMTP id 84mr21947840ybn.145.1643008227220; 
 Sun, 23 Jan 2022 23:10:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhhtn4SB7RLH4jt7wj+Jan8uDUEovwYqF3dz9S/9SdAU1CAK2pemFg3Tt7U6DQCJIlCCc8BjTtBZxKbfvpGJA=
X-Received: by 2002:a25:d57:: with SMTP id 84mr21947812ybn.145.1643008226799; 
 Sun, 23 Jan 2022 23:10:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
 <b000b664ed74dc8e52c7afe0061471c7f8e20d10.1642601554.git.luke.nowakowskikrijger@canonical.com>
In-Reply-To: <b000b664ed74dc8e52c7afe0061471c7f8e20d10.1642601554.git.luke.nowakowskikrijger@canonical.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 24 Jan 2022 15:10:12 +0800
Message-ID: <CAEemH2dBUSfn09+gAjH3tLDifoMevoaqDWNFa+hHKe_SDd7-5w@mail.gmail.com>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 05/16] API/cgroup: Add more controllers to
 tst_cgroup
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Jan 19, 2022 at 10:44 PM Luke Nowakowski-Krijger
<luke.nowakowskikrijger@canonical.com> wrote:
>
> Add more controllers so that they can be mounted and used using the
> cgroup C api.
>
> Most of the controllers used in controllers tests are added and a
> reasonable working set of the controller control files that I came
> across are added as well.
>
> Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
> ---
>  lib/tst_cgroup.c | 153 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 152 insertions(+), 1 deletion(-)
>
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index df541d26a..3d56a3364 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -84,8 +84,20 @@ enum cgroup_ctrl_indx {
>         CTRL_MEMORY = 1,
>         CTRL_CPU,
>         CTRL_CPUSET,
> +       CTRL_IO,
> +       CTRL_PIDS,
> +       CTRL_RDMA,
> +       CTRL_HUGETLB,
> +       CTRL_CPUACCT,
> +       CTRL_DEVICES,
> +       CTRL_FREEZER,
> +       CTRL_NETCLS,
> +       CTRL_NETPRIO,
> +       CTRL_BLKIO,
> +       CTRL_MISC,
> +       CTRL_PERFEVENT

Maybe add CTRL_DEBUG as well? Though most of the platform
diable CONFIG_CGROUP_DEBUG by default, cgroup_fj_function.sh
test debug ctrl and report an error with unknown controller:
(this config is always seen in debug-kernel)

  tst_cgroup.c:902: TBROK: 'debug' controller is unknown to LTP



>  };
> -#define CTRLS_MAX CTRL_CPUSET
> +#define CTRLS_MAX CTRL_PERFEVENT
>
>  /* At most we can have one cgroup V1 tree for each controller and one
>   * (empty) v2 tree.
> @@ -181,6 +193,109 @@ static const struct cgroup_file cpuset_ctrl_files[] = {
>         { }
>  };
>
> +static const struct cgroup_file io_ctrl_files[] = {
> +       { "io.state", NULL, CTRL_IO },

io.stat?

> +       { "io.cost.qos", NULL, CTRL_IO },
> +       { "io.cost.model", NULL, CTRL_IO },
> +       { "io.weight", NULL, CTRL_IO },

io.bfq.weight?

> +       { "io.max", NULL, CTRL_IO },
> +       { "io.pressure", NULL, CTRL_IO },
> +       { }

I'm not sure if we have the same cgroup configurations, here I
got many different ctrl_files on V2:

# cat cgroup.controllers
cpuset cpu io memory hugetlb pids
# grep -i CGROUP_IO /boot/config-5.14.0-42.el9.aarch64
CONFIG_BLK_CGROUP_IOLATENCY=y
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set

# ls |grep io
io.bfq.weight
io.latency
io.max
io.pressure
io.stat


> +};
> +
> +static const struct cgroup_file pids_ctrl_files[] = {
> +       { "pids.max", "pids.max", CTRL_PIDS },
> +       { "pids.current", "pids.current", CTRL_PIDS },

I'm afraid there is no "pids.max|current" in the cgroup V1 directory.

> +       { }
> +};
> +
> +static const struct cgroup_file rdma_ctrl_files[] = {
> +       { "rdma.max", "rdma.max", CTRL_RDMA },
> +       { "rdma.current", "rdma.current", CTRL_RDMA },

Here as well, can you recheck them exist in V1?

> +       { }
> +};
> +
> +#define HUGETLB_ENTRY(SIZE) \
> +       { "hugetlb.SIZE.max", "hugetlb.SIZE.limit_in_bytes", CTRL_HUGETLB }, \
> +       { "hugetlb.SIZE.current", "hugetlb.SIZE.usage_in_bytes", CTRL_HUGETLB }, \
> +       { "hugetlb.SIZE.rsvd.max", "hugetlb.SIZE.rsvd.limit_in_bytes", CTRL_HUGETLB }, \
> +       { "hugetlb.SIZE.rsvd.curent", "hugetlb.SIZE.rsvd.usage_in_bytes", CTRL_HUGETLB }, \
> +       { "hugetlb.SIZE.rsvd.max_usage_in_bytes", "hugetlb.SIZE.rsvd.max_usage_in_bytes", CTRL_HUGETLB }, \
> +       { "hugetlb.SIZE.max_usage_in_bytes", "hugetlb.SIZE.max_usage_in_bytes", CTRL_HUGETLB }, \
> +       { "hugetlb.SIZE.events", NULL, CTRL_HUGETLB }, \
> +       { "hugetlb.SIZE.events.local", NULL, CTRL_HUGETLB }, \
> +       { "hugetlb.SIZE.failcnt", "hugetlb.SIZE.failcnt", CTRL_HUGETLB }, \
> +       { "hugetlb.SIZE.rsvd.failcnt", "hugetlb.SIZE.rsvd.failcnt", CTRL_HUGETLB },
> +
> +// TODO Add rest of hugetlb entries or find better way to reference files
> +static const struct cgroup_file hugetlb_ctrl_files[] = {
> +       HUGETLB_ENTRY(2MB)
> +       HUGETLB_ENTRY(1GB)
> +       { }
> +};
> +
> +static const struct cgroup_file cpuacct_ctrl_files[] = {
> +       { "cpuacct.state", "cpuacct.state", CTRL_CPUACCT },

cpuacct.stat?

> +       { "cpuacct.usage", "cpuacct.usage", CTRL_CPUACCT },
> +       { "cpuacct.usage_all", "cpuacct.usage_all", CTRL_CPUACCT },
> +       { "cpuacct.usage_percpu", "cpuacct.usage_percpu", CTRL_CPUACCT },
> +       { "cpuacct.usage_percpu_sys", "cpuacct.usage_percpu_sys", CTRL_CPUACCT },
> +       { "cpuacct.usage_percpu_user", "cpuacct.usage_percpu_user", CTRL_CPUACCT },
> +       { "cpuacct.usage_sys", "cpuacct.usage_sys", CTRL_CPUACCT },
> +       { "cpuacct.usage_user", "cpuacct.usage_user", CTRL_CPUACCT },
> +       { }
> +};
> +
> +static const struct cgroup_file devices_ctrl_files[] = {
> +       { "devices.allow", "devices.allow", CTRL_DEVICES },
> +       { "devices.deny", "devices.deny", CTRL_DEVICES },
> +       { "devices.list", "devices.list", CTRL_DEVICES },
> +       { }
> +};
> +
> +static const struct cgroup_file freezer_ctrl_files[] = {
> +       { "freezer.parent_freezing", "freezer.parent_freezing", CTRL_FREEZER },
> +       { "freezer.self_freezing", "freezer.self_freezing", CTRL_FREEZER },
> +       { "freezer.parent_state", "freezer.parent_state", CTRL_FREEZER },

freezer.state?

> +       { }
> +};
> +
> +static const struct cgroup_file netcls_ctrl_files[] = {
> +       { "net_cls.classid", "net_cls.classid", CTRL_NETCLS },
> +       { }
> +};
> +
> +static const struct cgroup_file netprio_ctrl_files[] = {
> +       { "net_prio.ifpriomap", "net_prio.ifpriomap", CTRL_NETPRIO },
> +       { "net_prio.prioidx", "net_prio.prioidx", CTRL_NETPRIO },
> +       { }
> +};
> +
> +static const struct cgroup_file blkio_ctrl_files[] = {
> +       { "blkio.reset_stats", "blkio.reset_stats", CTRL_BLKIO },
> +       { "blkio.throttle.io_service_bytes", "blkio.io_service_bytes", CTRL_BLKIO },
> +       { "blkio.throttle.io_service_bytes_recursive", "blkio.throttle.io_service_bytes_recursive", CTRL_BLKIO },
> +       { "blkio.throttle.io_serviced", "blkio.throttle.io_serviced", CTRL_BLKIO },
> +       { "blkio.throttle.io_serviced_recursive", "blkio.throttle.io_serviced_recursive", CTRL_BLKIO },
> +       { "blkio.throttle.read_bps_device", "blkio.throttle.read_bps_device", CTRL_BLKIO },
> +       { "blkio.throttle.read_iops_device", "blkio.throttle.read_iops_device", CTRL_BLKIO },
> +       { "blkio.throttle.write_bps_device", "blkio.throttle.write_bps_device", CTRL_BLKIO },
> +       { "blkio.throttle.write_iops_device", "blkio.throttle.write_iops_device", CTRL_BLKIO },
> +       { }
> +};
> +
> +static const struct cgroup_file misc_ctrl_files[] = {
> +       { "misc.capacity", "misc.capacity", CTRL_MISC },
> +       { "misc.current", "misc.current", CTRL_MISC },
> +       { "misc.max", "misc.max", CTRL_MISC },
> +       { "misc.events", "misc.events", CTRL_MISC },
> +       { }
> +};
> +
> +static const struct cgroup_file perf_event_ctrl_files[] = {
> +       { }
> +};
> +
>  /* Lookup tree for item names. */
>  static struct cgroup_ctrl controllers[] = {
>         [0] = { "cgroup", cgroup_ctrl_files, 0, NULL, 0 },
> @@ -193,6 +308,42 @@ static struct cgroup_ctrl controllers[] = {
>         [CTRL_CPUSET] = {
>                 "cpuset", cpuset_ctrl_files, CTRL_CPUSET, NULL, 0
>         },
> +       [CTRL_IO] = {
> +               "io", io_ctrl_files, CTRL_IO, NULL, 0
> +       },
> +       [CTRL_PIDS] = {
> +               "pids", pids_ctrl_files, CTRL_PIDS, NULL, 0
> +       },
> +       [CTRL_RDMA] = {
> +               "rdma", rdma_ctrl_files, CTRL_RDMA, NULL, 0
> +       },
> +       [CTRL_HUGETLB] = {
> +               "hugetlb", hugetlb_ctrl_files, CTRL_HUGETLB, NULL, 0
> +       },
> +       [CTRL_CPUACCT] = {
> +               "cpuacct", cpuacct_ctrl_files, CTRL_CPUACCT, NULL, 0
> +       },
> +       [CTRL_DEVICES] = {
> +               "devices", devices_ctrl_files, CTRL_DEVICES, NULL, 0
> +       },
> +       [CTRL_FREEZER] = {
> +               "freezer", freezer_ctrl_files, CTRL_FREEZER, NULL, 0
> +       },
> +       [CTRL_NETCLS] = {
> +               "net_cls", netcls_ctrl_files, CTRL_NETCLS, NULL, 0
> +       },
> +       [CTRL_NETPRIO] = {
> +               "net_prio", netprio_ctrl_files, CTRL_NETPRIO, NULL, 0
> +       },
> +       [CTRL_BLKIO] = {
> +               "blkio", blkio_ctrl_files, CTRL_BLKIO, NULL, 0
> +       },
> +       [CTRL_MISC] = {
> +               "misc", misc_ctrl_files, CTRL_MISC, NULL, 0
> +       },
> +       [CTRL_PERFEVENT] = {
> +               "perf_event", perf_event_ctrl_files, CTRL_PERFEVENT, NULL, 0
> +       },
>         { }
>  };
>
> --
> 2.32.0
>


--
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
