From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 14 Aug 2020 19:57:27 +0530
Subject: [LTP] WARNING: at kernel/trace/trace.c:1727
 update_max_tr_single.part.0+0xa8/0x148
In-Reply-To: <20200814084123.5b64c0cf@oasis.local.home>
References: <CA+G9fYvVEhs_HROaXaW70mWrp_z6N4mJ-3rfFs0iAcT9Kg3A1A@mail.gmail.com>
 <20200814084123.5b64c0cf@oasis.local.home>
Message-ID: <CA+G9fYv0mhj1VVb99mS1akTaQxZD9TBcrFVoU9pdctMhG1r8BQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, 14 Aug 2020 at 18:11, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 14 Aug 2020 14:53:36 +0530
> Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> > steps to reproduce:
> > # Boot qemu arm64 with trace configs enabled ^.
> > # cd /opt/ltp
> > # ./runltp -f tracing
>
> I don't run ltp, what  exactly is this doing?

LTP running ftrace stress testing

Test case :
------------
LOOP=200

# Use up to 10% of free memory
free_mem=`cat /proc/meminfo | grep '^MemFree' | awk '{ print $2 }'`
cpus=`tst_ncpus`

step=$(( $free_mem / 10 / $LOOP / $cpus ))

if [ $step -eq 0 ]; then
    step=1
    LOOP=50
fi

while true; do
    new_size=1
    i=0
    while [ $i -lt $LOOP ]; do
        echo $new_size > "$TRACING_PATH"/buffer_size_kb  ----> Test
got failed here
        new_size=$(( $new_size + $step ))
        i=$((i + 1))
    done

    i=0
    while [ $i -lt $LOOP ]; do
        new_size=$(( $new_size - $step ))
        echo $new_size > "$TRACING_PATH"/buffer_size_kb
        i=$((i + 1))
    done
    sleep 1
done


test case link,
https://raw.githubusercontent.com/linux-test-project/ltp/master/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_buffer_size_kb.sh

ftrace_buffer_size_kb.sh: line 33: echo: write error: Cannot allocate memory
ftrace_buffer_size_kb.sh: line 33: echo: write error: Cannot allocate memory
ftrace_buffer_size_kb.sh: line 33: echo: write error: Cannot allocate memory
ftrace_buffer_size_kb.sh: line 33: echo: write error: Cannot allocate memory
ftrace_buffer_size_kb.sh: line 33: echo: write error: Cannot allocate memory
[   90.729590] ------------[ cut here ]------------
[   90.729882] WARNING: CPU: 1 PID: 2840 at
kernel/trace/ring_buffer.c:1273 rb_set_head_page+0x7c/0x108
[   90.733593] Modules linked in: rfkill snd_soc_hdmi_codec
crct10dif_ce adv7511 cec qcom_spmi_temp_alarm rtc_pm8xxx msm
snd_soc_msm8916_analog qcom_camss mdt_loader videobuf2_dma_sg
v4l2_fwnode videobuf2_memops snd_soc_lpass_apq8016 i2c_qcom_cci
drm_kms_helper snd_soc_lpass_cpu qcom_rng snd_soc_msm8916_digital
videobuf2_v4l2 snd_soc_lpass_platform snd_soc_apq8016_sbc
snd_soc_qcom_common videobuf2_common qrtr ns socinfo display_connector
drm rmtfs_mem fuse
[   90.761426] CPU: 1 PID: 2840 Comm: cat Not tainted 5.8.0-next-20200814 #1
[   90.782653] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[   90.789423] pstate: 60000085 (nZCv daIf -PAN -UAO BTYPE=--)
[   90.796165] pc : rb_set_head_page+0x7c/0x108
[   90.801416] lr : rb_per_cpu_empty+0x18/0x88
[   90.805922] sp : ffff80001673bc30

File and line number:
kernel/trace/ring_buffer.c:1273 rb_set_head_page

static struct buffer_page *
rb_set_head_page(struct ring_buffer_per_cpu *cpu_buffer)
{
    struct buffer_page *head;
    struct buffer_page *page;
    struct list_head *list;
    int i;

    if (RB_WARN_ON(cpu_buffer, !cpu_buffer->head_page))
        return NULL;

    /* sanity check */
    list = cpu_buffer->pages;
    if (RB_WARN_ON(cpu_buffer, rb_list_head(list->prev->next) != list))
        return NULL;

    page = head = cpu_buffer->head_page;
    /*
     * It is possible that the writer moves the header behind
     * where we started, and we miss in one loop.
     * A second loop should grab the header, but we'll do
     * three loops just because I'm paranoid.
     */
    for (i = 0; i < 3; i++) {
        do {
            if (rb_is_head_page(cpu_buffer, page, page->list.prev)) {
                cpu_buffer->head_page = page;
                return page;
            }
            rb_inc_page(cpu_buffer, &page);
        } while (page != head);
    }

    RB_WARN_ON(cpu_buffer, 1);  ---> pointing this link number 1273

Full test case output and kernel warning,
https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200814/testrun/3066187/suite/linux-log-parser/test/check-kernel-bug-1668287/log

- Naresh Kamboju

>
> -- Steve
