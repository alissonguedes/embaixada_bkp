<!-- CSS ================================================== -->
<link rel="stylesheet" href="{{ asset('css/layout.css') }}">
<link rel="stylesheet" href="{{ asset('css/internas.css') }}">
<link rel="stylesheet" href="{{ asset('css/lightbox.css') }}">
<link rel="stylesheet" href="{{ asset('css/sss.css') }}">
<link rel="stylesheet" href="{{ asset('css/css3.css') }}" type="text/css">

<!-- Favicons ================================================== -->
<link rel="shortcut icon" href="favicon.png">

<style>
    .material-tooltip,
    .tabs .tab,
    span.badge {
        text-align: center
    }

    .material-tooltip,
    .tabs .tab,
    span.badge {
        text-align: center
    }

    .material-tooltip {
        position: absolute;
        visibility: hidden;
        background-color: #323232;
        opacity: 0
    }

    @media only screen and (max-width:992px) {
        .tabs {
            display: -webkit-box;
            display: -webkit-flex;
            display: -ms-flexbox;
            display: flex
        }

        .tabs .tab {
            -webkit-box-flex: 1;
            -webkit-flex-grow: 1;
            -ms-flex-positive: 1;
            flex-grow: 1
        }

        .tabs .tab a {
            padding: 0 12px
        }
    }

    .material-tooltip {
        font-size: 1rem;
        line-height: 120%;
        z-index: 2000;
        top: 0;
        left: 0;
        overflow: hidden;
        max-width: calc(100% - 4px);
        min-height: 36px;
        padding: 10px 8px;
        pointer-events: none;
        color: #fff;
        border-radius: 2px
    }

    .tooltip-class {
        overflow: hidden
    }

    .jqstooltip {
        box-sizing: content-box;
        border: none !important
    }

    .tooltip-class {
        width: 30px;
        height: 20px;
        color: #fff
    }

    #ct2-chart .ct-series.ct-series-a .ct-area {
        fill: #00bcd4
    }

    #ct2-chart .ct-series.ct-series-a .ct-point {
        stroke: #00bcd4
    }

    #ct2-chart .ct-series.ct-series-a .ct-line {
        stroke: #54e2f4
    }

    .socialbox .logo {
        font-size: 28px;
        position: absolute;
        bottom: 20px;
        left: 20px;
        color: #fff
    }

    .socialbox .info {
        font-size: 15px;
        position: absolute;
        right: 20px;
        bottom: 20px;
        margin: 0;
        padding: 0;
        color: #fff
    }

    .chartist-tooltip.tooltip-show {
        display: inline-block
    }

    .chartist-tooltip {
        display: none
    }

    .ql-tooltip {
        left: 0 !important
    }

    .snow-container .ql-tooltip input[type=text] {
        width: 100px
    }

    .ql-tooltip {
        left: 0 !important
    }

    .email-compose-sidebar .quill-wrapper .snow-container .ql-tooltip input[type=text] {
        width: 100px
    }

    .email-compose-sidebar .quill-wrapper .ql-editor.ql-blank::before {
        left: .3rem
    }

    .email-compose-sidebar .quill-wrapper .ql-editor {
        min-height: 7.93rem;
        padding: 0
    }

    .email-compose-sidebar .cancel-email-item {
        background: #ff9100
    }

    .email-compose-sidebar .send-email-item {
        background-color: #2196f3
    }

    .email-overlay {
        position: absolute;
        z-index: 999;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
        visibility: hidden;
        opacity: 0
    }

    .email-overlay.show {
        visibility: visible;
        -webkit-transition: all .3s ease;
        transition: all .3s ease;
        opacity: 1;
        background-color: rgba(0, 0, 0, .2)
    }

    @media (max-width:900px) {
        .content-area {
            margin-top: -110px !important
        }

        .content-area.content-left,
        .content-area.content-right {
            z-index: 1;
            float: none !important;
            width: 100%
        }

        .sidebar .sidebar-content .sidenav-trigger {
            top: 87px
        }
    }

    .material-tooltip {
        font-size: 1rem;
        line-height: 120%;
        z-index: 2000;
        top: 0;
        left: 0;
        overflow: hidden;
        max-width: calc(100% - 4px);
        min-height: auto !important;
        padding: 10px 8px;
        pointer-events: none;
        color: #fff;
        border-radius: 2px;
        top: 170px !important;
    }

</style>
